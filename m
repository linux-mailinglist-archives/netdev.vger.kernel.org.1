Return-Path: <netdev+bounces-75734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855786B01C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42883281D32
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C8514A4F9;
	Wed, 28 Feb 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ederND5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764F3BBEE
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126424; cv=none; b=TaPCw4ekKTQL8jO9J1gwHyl79N5+iX+aKeNRPFP7uMBLNXq5puo9z+ClZnWXzZ1G7gUQYodREuv7SGIfvgwXSewvsb/yO4Dbx41JQgwblopd9pG7bRCv5wgNvCnuIA7uE0qSH4AO/l4UzHRYAE8ED3Q9F3HvRHeFqlMqVCKhwxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126424; c=relaxed/simple;
	bh=FCXls9vyaYreJmW53Y4NKmxSEpJJ82BaNJ35k7XiyLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oPhZi84FMiodBN1Vy++v9pfFSgj3clJatybqSXqA6DhYWHWO2+++nBRpRavauNwSpMUnYMXv69XDJTGthm4B/HNVzzdYM1fuDPo5qnXlUsJsOIZDcsNaZ9CwJvzb/c1J223SRzxX2VALW+pyXZ/22ir2Rvj2ezJ/NRhWGvtWwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ederND5r; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso513037f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709126420; x=1709731220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXazDuiRBMVvNWQAjzp0m8JrdU/HI8jGHH8P4CB6exY=;
        b=ederND5rt6GQeYtNbQO5a8woHU6jnqzNxPDsq6mKQNlE9sTPcNejWr7cGOokuqBgtx
         AS4Z8sctVzNbQ9dQ+ssyShQlRsk0gez86rrPos3wCFgUu2y1xAVLzoCc4QLEWFx/Os+P
         PWIxv2ctbDJGhZGv6ajaoLMcuSa8LOcRLCqw8gSGZ62E5XuHVeVrtuJeuDPPGqTp+nt6
         nfmeNrJq/a7Fz/MyjJKGMLoB7XQaZL9NL6qZyJKDEDKWdq1yU5CHPxHvsRInSbxfTWhH
         Xdelxw5+LIL1gtSO1LBG+5rKo052nQ+1Z1uXl6zeqqHEIamYCV03SIUCorLTj25ltXV/
         YsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126420; x=1709731220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXazDuiRBMVvNWQAjzp0m8JrdU/HI8jGHH8P4CB6exY=;
        b=KdHx6AzRdByAh5TIRFkKUeelMa+tCzfB0ezRZtHtxrMQiDN3wMZkdmjL5TUNfy5+hN
         iN0XMfLtp0ruZzZx9fVPV6HWnJfK0BCBMqhCrCUk/ZLac2f96ds1xPV4OJQL8rOUrSI5
         PqKMLTP8lhZ/2lNJFnpm92PQ/qaXJXEdzvy+oQgwrvSnbCeeJiof4AM9M58CmIKFxSb3
         4vFqkMRwiatpbVlchOrAaL6jB7/CJ0lGHoJAKMfjscXWCR6xZjcsyda6xXCir9SwruQn
         gcBZ80oYod0rj3mOwMVgYQkq+obJiB8wTk8ojVXG2/55N8XeOmtGhzzJzzsrVlxzgdcY
         oOEA==
X-Forwarded-Encrypted: i=1; AJvYcCU08DD4X2mcptKUMRV0clB+ADF/DGdJ9YTeoGGlEV2bQ7ujsF/KewC4P1LgTuEVu7JoC2JU87cwi3Aa8eyMvxdCoBd7AG/6
X-Gm-Message-State: AOJu0YyBiSlgesfkBpkykjtHI94WAT3mgNZx/iC5OTtrfxQ5m6SfLPHb
	MKYCd6qCJCY02M6IO6qip60JLsWwax/0TFi4kigLIryPcs27dr61tN0UlDGTa6I85tIaDYmZ4lh
	a
X-Google-Smtp-Source: AGHT+IGfc5LZrbSohF91mGVAvRehcemHfRZURZp1cn6omFLZPlKPTTTJHtLB0erynGTdCUECdGSgPA==
X-Received: by 2002:a5d:68ce:0:b0:33e:30a:c6bd with SMTP id p14-20020a5d68ce000000b0033e030ac6bdmr1304119wrw.6.1709126420138;
        Wed, 28 Feb 2024 05:20:20 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0033d2541b3e1sm15330529wrb.72.2024.02.28.05.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:20:19 -0800 (PST)
Date: Wed, 28 Feb 2024 14:20:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: William Tu <witu@nvidia.com>, netdev@vger.kernel.org, jiri@nvidia.com,
	bodong@nvidia.com, tariqt@nvidia.com, yossiku@nvidia.com,
	kuba@kernel.org
Subject: Re: [PATCH net-next RFC 1/2] devlink: Add shared descriptor eswitch
 attr
Message-ID: <Zd8zECmvTWF_gZO5@nanopsycho>
References: <20240228015954.11981-1-witu@nvidia.com>
 <20240228131249.GE292522@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228131249.GE292522@kernel.org>

Wed, Feb 28, 2024 at 02:12:49PM CET, horms@kernel.org wrote:
>On Wed, Feb 28, 2024 at 03:59:53AM +0200, William Tu wrote:
>
>...
>
>> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
>> index c81cf2dd154f..ac8b0c7105dd 100644
>> --- a/net/devlink/netlink_gen.c
>> +++ b/net/devlink/netlink_gen.c
>> @@ -194,12 +194,14 @@ static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NA
>>  };
>>  
>>  /* DEVLINK_CMD_ESWITCH_SET - do */
>> -static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
>> +static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT + 1] = {
>>  	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
>>  	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
>>  	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 1),
>>  	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U16, 3),
>>  	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
>> +	[DEVLINK_ATTR_ESWITCH_SHRDESC_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
>> +	[DEVLINK_ATTR_ESWITCH_SHRDESC_COUNT] = NLA_POLICY_MAX(NLA_U32, 65535),
>>  };
>
>Hi William,
>
>I realise this is probably not central to your purpose in sending an RFC,
>but my understanding is that the max value set using NLA_POLICY_MAX
>is of type s16, and thus 65535 is too large - it becomes -1.
>
>Flagged by W=1 build with clang-17.

First of all:
/* Do not edit directly, auto-generated from: */
/*      Documentation/netlink/specs/devlink.yaml */



>
>>  
>>  /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
>
>...
>

