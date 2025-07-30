Return-Path: <netdev+bounces-211056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC7B165CA
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 19:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8056B18C33C9
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AA2DCF45;
	Wed, 30 Jul 2025 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aksoV2em"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6512A1E0DE8
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 17:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897775; cv=none; b=hiWNLzpiITIe20PBsjT6VYrBgosqBhb7hM7G5A32m48k57hRmiCCK1JXe8/AqVb0cGIj9TvbcWUPPR20Qufm0quaKHTNdeWv4X86NKRlFuzSX/OBDM00OBoYDl2Uyi+g1RsGQl9/K5xh1Z8mlFHxki+mXSOV2OkthqRlOYRwbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897775; c=relaxed/simple;
	bh=yjrtvIg09XitkHpDg1ILifO+9jc0chDTHjXAhQ+wha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8BdR9+JmB/5INqEz3Qc+yDGRWc7Rf8O1E4UESSp5O779vfzz6NeVvaueNzGsm5WCkdz0WdU5USzJoRxb7E5IMnxEDhivvWo+GGzwIjN8IFAb0wP6hlQu79qXshUJnrhUtCpdQLkcqk+/Ncp0NA2+TUzCul2FGhqZehs9hhB4sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aksoV2em; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b42099901baso34055a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753897774; x=1754502574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G0+YnddlMh+6gv1cg0TPjOVfJReVP+puPgr15Z4Fbuo=;
        b=aksoV2emlknnT4DS73dhGhq8n6qmL3d60byPU70zDrepRl9tSkS/VMF3Z7oWR/nGLW
         jSKD9T9fAQn3pRi72+iHoBakqZONkeuG8JTPI7+kj8ZUZtG14GziV1slECXoQ4T++QiY
         wDM+XkU1ZJ+p3C5ih67QvA6TxEOZGT7TUeDTHnMkkGinpFw/5TPixQLWZOx3E6y1cNNh
         yTHUAxnjOOzPNoIEGxfXO3wQIwCJ3wwOGeeFeRK4bIyvBawl2U3j9oqzNBD3RHGjaa1q
         0nyf6+kyCcZ75rpkqn/TR/yUijc+YrnZwBfg00HwfOagWNVRAHzS+EQJsikL8nS/r7ym
         hFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753897774; x=1754502574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0+YnddlMh+6gv1cg0TPjOVfJReVP+puPgr15Z4Fbuo=;
        b=mmh+GKes+nnQ1Lw+Vc2R0G++FtOLGmXOfcE08Cdrz5+GkASKPhzqRSFZt/GDUP33/O
         njBQ0RF6W3x86055J/uVOFlPcFymBOAkMkB4vrOC7+DzNj53xGi7f7CcTh49S8PnWJ43
         VafVNzsJfccA4x2FsMDCM2qDwKhagVN6qvR2x9XAie9eIc9O/PDCBJKeXXovVehYWY+Z
         bq9IRTtv23NQnfpcDCBcHE2d/7vxNugjOwNgqhhQth0flpGmA/o48Z0Vmnik5M0UKAHd
         BDbi5mY73tBLrBUV8Y6UUGm3B3Qw7IhSvy2dKgmnE1gaW/OZ90QXpscXXiAZpIOKAw/N
         j+/w==
X-Forwarded-Encrypted: i=1; AJvYcCVRPO+lEshTjukQdyrEZHIL0agiK2/WuVcu7JodiGkbHJ4uY/ZEUE96jMdLr8+PwHIbw+g6DZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+aUbnOKTsr5e7Fo3yDoJWHpa47WZbsh0zJza3pc81h0nXAxr
	lc16aXuC+9bL2F5EvqlaF5W/z4JETxXD0cw5UMkngRZ+/5GWHDvOxXso
X-Gm-Gg: ASbGncvoStZcOGKzRQZIUNebPkdZcznglawwwgmwUkKgjZ6NSXjjTr3Ec4CPzjOrwNv
	qIwC+mlecGFKnAFOB7D8f7389TDH/7HOkJzMz1zB+YR13uerq/UfKZt3lJ58NEuAiBWB5qNwHd+
	Q4M8Fsa4IPiVibzyVI0BOPsJ/6oq3qu1NAh/onufFS8fI+yzgpZIluCyO+b1eMeKVv0zRenoufR
	1EBtLlHe6tVJ0NAt/0pVFpg0tjtHjK1iiWXY3Fcq/TWzVNgMp8Ld3oPyX9RXbz2BwveJyvrepPJ
	/LBOonKvtbcAi7HnjwbQTL3bCb6NxfhkvLw7IrJPOg48u0h1i5b4ckq/lkxu/kfLe4ZCMn3DL2t
	0NgFDmBE9sA0WbpSKA/htK4m7cQ==
X-Google-Smtp-Source: AGHT+IEqSeYP8olnbr4zo7cLFx7qpiPtvgEXdMNC9RBmqoXX3pBy/Yq/lK/6j5OFt6A1X0LfXZsPsg==
X-Received: by 2002:a17:902:f68f:b0:240:2e99:906c with SMTP id d9443c01a7336-24096aa3ca2mr59534805ad.15.1753897773653;
        Wed, 30 Jul 2025 10:49:33 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe32a2c6sm106741275ad.60.2025.07.30.10.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 10:49:32 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:49:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Takamitsu Iwai <takamitz@amazon.co.jp>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>, takamitz@amazon.com,
	syzbot+398e1ee4ca2cac05fddb@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 net] net/sched: taprio: enforce minimum value for
 picos_per_byte
Message-ID: <aIpbK1q47giH8SRg@pop-os.localdomain>
References: <20250728173149.45585-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728173149.45585-1-takamitz@amazon.co.jp>

On Tue, Jul 29, 2025 at 02:31:49AM +0900, Takamitsu Iwai wrote:
> Syzbot reported a WARNING in taprio_get_start_time().
> 
> When link speed is 470,589 or greater, q->picos_per_byte becomes too
> small, causing length_to_duration(q, ETH_ZLEN) to return zero.
> 
> This zero value leads to validation failures in fill_sched_entry() and
> parse_taprio_schedule(), allowing arbitrary values to be assigned to
> entry->interval and cycle_time. As a result, sched->cycle can become zero.
> 
> Since SPEED_800000 is the largest defined speed in
> include/uapi/linux/ethtool.h, this issue can occur in realistic scenarios.
> 
> To ensure length_to_duration() returns a non-zero value for minimum-sized
> Ethernet frames (ETH_ZLEN = 60), picos_per_byte must be at least 17
> (60 * 17 > PSEC_PER_NSEC which is 1000).
> 
> This patch enforces a minimum value of 17 for picos_per_byte when the
> calculated value would be lower, and adds a warning message to inform
> users that scheduling accuracy may be affected at very high link speeds.

Is it possible to reproduce this with a selftest? If so, please consider
adding one.

Thanks.

