Return-Path: <netdev+bounces-82922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB5890325
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6891F237AF
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D42F12FB0E;
	Thu, 28 Mar 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJEcU8lu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53727E583
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640121; cv=none; b=aO63pnLlSTR0QouGE71q0I7guMbXxR3M2ZPM0RMPin0wWQx1l54jMaB9gyZrf385Ol/oQWvfkVknqD202cn2ezhBB20ZKKlx4tRRQeH8cx/WT5RQyMY7iFNUr64jOfhq0o88WGLZzc4ANO7++F8qn4gp/q4GNlItzmJt08ckFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640121; c=relaxed/simple;
	bh=fMfv3Ld49PT/HPbhLI9/A8ixSk9a/riZ8jLDrVurFo8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=bcM51I/XdugoQ0lSdJmsICCzyZi3M0y8ljoQxzrD4k9hIZbc//BnivoXRzS2Riow09h8iltBRWZdTRLgPYqAITyNa6zaGTpz96C6DFGj5OzZ4FON/wEtUw6o6Jigd0lJh+ivI3bDPrmxvz7lYRYbItfMEpPihNGK/S7V/5gI0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJEcU8lu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33ed4dd8659so1424054f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711640118; x=1712244918; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiRuc0mfwQVa6ovRxTK/A6HN16gXj4h6RMICJd+5hjM=;
        b=aJEcU8luo+YE3ly2W/ZxMmjtg8Jf48qg2SoZLUVKGa52aBYqEKMooaei+S34hR3ZFi
         Tu7NfuPAE1YwqKzfSmUWa/iXLdgAZ9t23rGkpK1bwPNqco4RlDkJ7dxbrjTPCgxVfpvh
         +s2/R2VWj+fFMztMsAW3GDyT69V6MO63lFd6slDK5BLA25eVLHuqnLyQd3SX9exDn/NU
         uoHLcqAqyLe2aa7+c7+5AXiCLSCdnAC7CZrjO59OKbbkmrstRUkpjFKs32b8yU0p8PjL
         q2+v3Lr/sFVhwAaNsiEgn00c1o30oQyT3lvc2zseugoAtEx0OtCx1J/UQ0bvKLgbm/sw
         JURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640118; x=1712244918;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiRuc0mfwQVa6ovRxTK/A6HN16gXj4h6RMICJd+5hjM=;
        b=HrXJv/pqpaiTFvmn56TLKNsmrau9GPJRPGpiQGAYBtSyr9cL5joaDlA9ryJ3HwImmM
         A+q7oZrvTYfhcw1o3QpVVXsEkHo99w9EKrCSH4p0opTgJ0tZmGFF7GMTTd53omJ4yagX
         4vmrGrWfMlcxTIpcyErGmU8N2Ir4x2G6Tulk+QQUNcjEFDc1DFFnGOsBSTixrT8GmyGW
         KGD/jl51WWf56GVvh7VfIDVg3NuJ/FCWY9EFUyE10TqoFTD/wUUONOXnYEgWY+yRAFNw
         /ROom8onH4XAj3aLT3X2RNacXHkFBFbCfTT4qLUynyHY4SyQrpajoLIpul9VDDl24k85
         GoxA==
X-Gm-Message-State: AOJu0YydQq7Lsl8Hsjwk3wFGi3ZaoEc9tqbqtXWZc0k4gRWG50x4DLzS
	aqV63DSEhkPwndDgV0VIbhwQ58Oc4jJJZ9Q17whaOVlAjIjfyTpz
X-Google-Smtp-Source: AGHT+IEbSyv32iBGqoKwrAFYPGlxKvxWMWH2gw5BE93KCXKcKTytLafnLmpheJbPUL7jRRl2YBb36Q==
X-Received: by 2002:a5d:4583:0:b0:343:35b5:240 with SMTP id p3-20020a5d4583000000b0034335b50240mr125415wrq.29.1711640117808;
        Thu, 28 Mar 2024 08:35:17 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7530:d5b0:adf6:d5c5])
        by smtp.gmail.com with ESMTPSA id g1-20020adfa481000000b00341e7e52802sm2040302wrb.92.2024.03.28.08.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:35:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jiri
 Pirko <jiri@resnulli.us>,  Jacob Keller <jacob.e.keller@intel.com>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools/net/ynl: Add extack policy attribute
 decoding
In-Reply-To: <20240327174731.6933ed21@kernel.org> (Jakub Kicinski's message of
	"Wed, 27 Mar 2024 17:47:31 -0700")
Date: Thu, 28 Mar 2024 15:32:04 +0000
Message-ID: <m2sf0ajrt7.fsf@gmail.com>
References: <20240327160302.69378-1-donald.hunter@gmail.com>
	<20240327174731.6933ed21@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 27 Mar 2024 16:03:02 +0000 Donald Hunter wrote:
>
> Nice!
>
> Some optional comments below...
>
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
>> +                policy['min-value-s'] = attr.as_scalar('s64')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
>> +                policy['max-value-s'] = attr.as_scalar('s64')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
>> +                policy['min-value-u'] = attr.as_scalar('u64')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
>> +                policy['max-value-u'] = attr.as_scalar('u64')
>
> I think the signed / unsigned thing is primarily so that decode knows
> if its s64 or u64. Is it useful for the person seeing the decoded
> extack whether max was signed or unsigned?
>
> IOW are we losing any useful info if we stop the -u / -s suffixes?
>
> Otherwise I'd vote lose them.

Yep, makes sense, I'll collapse these into min-value and max-value.

>
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
>> +                policy['min-length'] = attr.as_scalar('u32')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
>> +                policy['max-length'] = attr.as_scalar('u32')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_IDX:
>> +                policy['policy-idx'] = attr.as_scalar('u32')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE:
>> +                policy['policy-maxtype'] = attr.as_scalar('u32')
>
> I don't think these two (policy-..) can actually pop up in extack.
> They are for cross-referencing nested policies in policy dumps.
> extack only carries constraints local to the attr.
>
> Up to you if you want to keep them.

Sure, I can drop these.

>
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BITFIELD32_MASK:
>> +                policy['bitfield32-mask'] = attr.as_scalar('u32')
>> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
>> +                policy['mask'] = attr.as_scalar('u64')
>> +        return policy
>> +
>>      def cmd(self):
>>          return self.nl_type
>>  

