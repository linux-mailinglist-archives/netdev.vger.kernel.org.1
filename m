Return-Path: <netdev+bounces-91214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE5F8B1B68
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEFE1F24BE3
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 07:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2222367C53;
	Thu, 25 Apr 2024 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fv/fN9Ut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7882C5FBB2
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714028667; cv=none; b=JST5Bkaix+//0WxlLvI32cGvcA2TRIdtQypXRpBwfZS74b3zKjSbVvSmpFucqBRpFWrDKmQyltFa5umJE5gNrvQlI09vAiBwzfX1seZUUEhxgeDki6lg67K57OlOQgASYuDvCeQXMupJpiDcRZMZK16Hfml77EOADHQe2qB9yQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714028667; c=relaxed/simple;
	bh=/VjRoJE3IXRNkRzEdSWJMoni3iSBje1meeBcc8jOQog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey/6p3/NLzZJJA59+XcsEwQTcBSdLQcjIrDCUZd4FxgxxpqRKy3/8gWNE/8fBDeUF+xGOdVF/V7n37cycTkbbgKKjumX+gXPeNQTDk0c0nuB5TCem70gO/glrnUV8c+k0kJEt3/i33AAzbQNvsGxdzN5F1ksx1oCCMMreYPR/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fv/fN9Ut; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso758274a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1714028664; x=1714633464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cBR6dncekgh5NrQLVvWpJ1bIu14pltXiH3AH2dGUbz4=;
        b=fv/fN9UtkXWJblrg9TIz7VD/qvIR03gSA2pGOslX/floDTrKnkQrkTqhPW3+f0MbXM
         Ikw3kyPXYf9NEYSu71ergzqF6T33BbiyOAbEyN0uETHwk2nvWsaF15FiUqE3VYCTzbw2
         UP07sP89k3o6cmxUJb/ezwBrkz6eFzWIU++ySSE+x+DfRk1MzC8Ino29adNovHBS4VZp
         DpsjTu5YMpoTyQyB+huyB+S39eLbAOwozjTNRHlNUMoveL3vFfXCbtbUMe0MGBm7wpot
         uDPhbZ0xz8GrFdVWcFwR0sGf3VFDGDSZiJfK28OUpicmp0gEi8urhS6R+rDI434mCDhu
         I/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714028664; x=1714633464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBR6dncekgh5NrQLVvWpJ1bIu14pltXiH3AH2dGUbz4=;
        b=UpoODyf9xVMoa5zbbtpuUhL4TkOPSShL12UBdV27lk6rRlT0sN4tAr+p3t1LfbFNAb
         CBKmrlVkyTkpC1+fB0CsU7K12yH6V2YlBEZdhqqvlRwBZonwIxZjoKjRDnkh2Tq3ftb1
         k6g5HPaa3nirQWGtlgSQwaEHs6euBpDBvG8xQsUW/SzPYq0Wy81xK0SNmFSAMtzcyAzz
         x9SIsZeVPmp3OpTqrP/vqDLxudlOIvPgr8KvKlEuqS1tNQ6RYrr9HevLTu9frwg6hUNL
         epLbMS5w6hvQ0bVGGTYkEA3/cE/JYmV/YrcRxbxjijHD7iE4pNXy5BZda2/svwRLXKCa
         VPlQ==
X-Gm-Message-State: AOJu0YwYkNrgGj1snbXeS5zWoWoavjicsDjLT+v7MwgGkrW8OmmA4wyM
	Ywm8l2lBcnB8xV3ZnM0PRzeuU8ZFL3pt6JGOUGBGBOV6z/XkBFRz5qC1/P8qOPs=
X-Google-Smtp-Source: AGHT+IEQ8s8854EseHNz+L2jLHovAq6W0eWl2AJR515h0d/Dmap6/1Bkc0yyTsrA4vgsxATiLZQQSg==
X-Received: by 2002:a50:9b55:0:b0:570:c8f:1a35 with SMTP id a21-20020a509b55000000b005700c8f1a35mr3456039edj.8.1714028663631;
        Thu, 25 Apr 2024 00:04:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id et6-20020a056402378600b0057245a3fd4bsm117790edb.68.2024.04.25.00.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:04:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 09:04:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next] net: qede: flower: validate control flags
Message-ID: <ZioAchImQ65ck1Ua@nanopsycho>
References: <20240424134250.465904-1-ast@fiberby.net>
 <Zikcq2S90S97h7Z0@nanopsycho>
 <923135c6-1bd1-414d-b574-c201644d35ab@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923135c6-1bd1-414d-b574-c201644d35ab@fiberby.net>

Wed, Apr 24, 2024 at 06:43:14PM CEST, ast@fiberby.net wrote:
>Hi Jiri,
>
>On 4/24/24 2:52 PM, Jiri Pirko wrote:
>> Wed, Apr 24, 2024 at 03:42:48PM CEST, ast@fiberby.net wrote:
>> > This driver currently doesn't support any flower control flags.
>> > 
>> > Implement check for control flags, such as can be set through
>> > `tc flower ... ip_flags frag`.
>> > 
>> > Since qede_parse_flow_attr() are called by both qede_add_tc_flower_fltr()
>> > and qede_flow_spec_to_rule(), as the latter doesn't having access to
>> > extack, then flow_rule_*_control_flags() can't be used in this driver.
>> 
>> Why? You can pass null.
>
>Ah, I see. I hadn't traced that option down through the defines,
>I incorrectly assumed that NL_SET_ERR_MSG* didn't allow NULL.
>
>Currently thinking about doing v2 in this style:
>
>if (flow_rule_match_has_control_flags(rule, extack)) {
>        if (!extack)
>                DP_NOTICE(edev, "Unsupported match on control.flags");
>        return -EOPNOTSUPP;
>}

Looks ok.

>
>pw-bot: changes-requested
>
>-- 
>Best regards
>Asbjørn Sloth Tønnesen
>Network Engineer
>Fiberby - AS42541

