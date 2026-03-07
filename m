Return-Path: <netdev+bounces-265044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GGxHGOcq2kJewEAu9opvQ
	(envelope-from <netdev+bounces-265044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B3229F08
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 04:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF355304A169
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6472EB84E;
	Sat,  7 Mar 2026 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/244M4C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6328A1E6
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772854247; cv=pass; b=S3to83h5JZ/e6QWKJ4i6bUjsVqt4KgeTOtZ3G0+5dMLF77udhszmWR/F8EG/Ol/uNgox2ZdH2hxPZYVRrUlGGvWbFYfC6i1Ina9oebSxQx8LC7KQmqQhHC8KwYzMSvugb6vQfcCqAPl9ByzqBJ9eFWviFqo9d9ogwxjFBPF2fOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772854247; c=relaxed/simple;
	bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSDZR1zIR5d6mpOmYZlqRm1Poj+RESdX9OPXbB7o7vHiA8q7kq+987vmYjbzH2Gyyf8CHfpghsf+fcAceWo3y2NLvJN6b6ugFK1mfHwvnByzGVPH6XTQYW1XalaDi4vfgoolYtXg1p+UO6KlbDGX68I2lSzz2un2dMUTf7c8vrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/244M4C; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50698970941so2215491cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 19:30:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772854245; cv=none;
        d=google.com; s=arc-20240605;
        b=SzemztWYPPZRQrkhQokiVi0OefCaaQ0oBK7HwRY997VxdzJnOw1CveMbYW3UYPw6gS
         aQ+TCRu2U5ErcLW0ie0CEoEWn8dR7TFRNEIWGTbFMDsPk8L4niNFLvf8bQvWBWPCqCEm
         LKZ/p8cJavb52dexQCoMdxnK8XtGu272VPUPDJGKAWSGxPUoWHlXOoYXcASgOrKEFZ1n
         DpK/9Av8HAygMIQIUzI0Sk0DRTAhtTFvy0sYVw54uEGeEvdSCIMi3lDYRoHIV7S2K0Hr
         2lzW4SaPfLwv5rI4SBg5AnOQpRFF850vbeGabOh0ms/UaI5Co0blW7KSbGF2Wjsd3cMQ
         s74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        fh=yGXqPsWEZjaBFQb2bkZ/rEfQqjHl0ykwG0YiSFbcCm8=;
        b=V1VdoYGj9PKgElWN8fohEvD+b/3qwbvDQZCZKmBEqcm/4nGdgZlyvWyl121Rk/p/RI
         v4b8ImrlFy+JKulrekAqwtqhe8ENi0T7IWuno+ydORAy1mgENikOui4EfZePWcAlziNo
         e6+7X+7Z9r9w0ut9CscYeLndW6jCLJ6zxXkG373BF6KN+8NYzLFr/M7GUQ147vHyDnCa
         pG380PVc+h31ZqJXZkGPNeMDgKYtEaYe6RNmPxa15RuuWoCYOzbyw2YGOOTsHk5+KN6l
         KzEyf7vDd1DumNrrO83pBY2bw+k7+a6L9Vfk7ee4CI8QEBtipOp/tHwKOBoxr+nhDnhh
         LKPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772854245; x=1773459045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        b=z/244M4Cv+rUbQwwujE3b/ZK8z5ovrq9jGaxMbZoZ+DZ7mk/F0cyC55wToOJOHkoYO
         g16p7dcgCekHtZT2ml/c6oQsyKXvIydn0wmPA3hMzxjbDMgkLoWXri+QLS/B+i99sbHV
         EfhLwua3Qo0m+hkasEGAx55F/s9XAYxYbUPC4T2OiyrXAZb63AVy0CHOBJO9CxEwAY6n
         ljFyJ7FThs9ia9TM50xGyXcM/wqZM+46S6NviYmi0OJ0sZVO24rJAZX+k9GfKUjuEstk
         3LhoWYKf8LgQs5RC4C0X03vIX9nGj/n8OibN2nhlP/fzN4z5bUC9vs5HlJjmmyxTT6q7
         ZwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772854245; x=1773459045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJp+EUY2BYaw4/mpGh2b4Iem8BljcSrMISuM2lan3Ic=;
        b=DnWPATwht+uZxKsd89nalk6D6kC96XNdjXFG85aWsd+oZv06EgrUvezYGnGnG5NR5M
         PqGybR0xmkSuKlvH914WPplY/4+IK2C86mLoZGWFD4f4zgLilRV02/rR8+Ju04PrERNR
         f13ayKuj4MR6ZzePFQFpVxJ84chD/E76x3SU/xS/g5xVHaiYGO/WMxLXjEGbrHU1B8SB
         f00L1r2fea9oDcH0bv/uEdG4uPnP0Rc+bTrxyrwLCVJ/cMxttmaj5yZD9XGWsj0qQchu
         Wbbwsj96rDCqL//SoJKKgwJDnkhX5E9up2OI+2PBtXGUAUU9SIfqTtWKIhwfKtiSl9dL
         9IBw==
X-Forwarded-Encrypted: i=1; AJvYcCVuqEVVgfoKw6KuYxqoW6ouDoB/J/LWMCroPtaMUmkmYrjC6om8vuXDJfqWZbBNPWlmRuNHPak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hsOD76vOO8x7g/pS88U20qh1YUPl6EcqUd7Ab+yNf1MKC+W3
	3WsbyNAvAGJdFSsuLxapUoctfggkT5AA8k0+tIVpahWw/Dvc50OYKpT8xk8pYsGzP8warsE0M7P
	zdVLgEJ+dps/VgeygelmnlmIdoeS+YL/4ZukuGjjU
X-Gm-Gg: ATEYQzxKgtfPh7EHULzAWr3qXQc0cVCwaq8PcDVr/WvUbVg5axALNBmtg3nyzkYEHNc
	y1oDa/88QK3s2B4wm6EOd/VQAQoiKnvgn/plbvCLXQEbtXQXePaOrR0A8Y+A/CbTo36mSY2iA8w
	WDTyblXOXlRKzjPuNVDn+jyk45jxebIeeLZ8ch7S5wQ2cK7sDyGSe56NeluFCJpjJZWPkxCtCEL
	jE5mZZyrIYDLNYC6X4tMJJnuuqQwN+/BgmEI2nBpuLeEshRBSvmEi8R6vwnKvWVvTKltTCLlhI+
	mLOd8zik
X-Received: by 2002:ac8:5f90:0:b0:4f3:4cd3:164c with SMTP id
 d75a77b69052e-508f4916bb2mr60826821cf.21.1772854244481; Fri, 06 Mar 2026
 19:30:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306233821.196789-1-mehulrao@gmail.com>
In-Reply-To: <20260306233821.196789-1-mehulrao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 04:30:33 +0100
X-Gm-Features: AaiRm52IxOwyQRAQ3DbMqKQin6IPUJE3w17Kvc7B_jjoZjTMnEHedgCvEMqhs0I
Message-ID: <CANn89iK6YAhfoEX2=dvJTrp4-JMjiDSmE0ELOCAt4j-m+-KVMQ@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: fix percpu use-after-free in remove_nh_grp_entry
To: Mehul Rao <mehulrao@gmail.com>
Cc: dsahern@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, petrm@nvidia.com, idosch@nvidia.com, 
	netdev@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7F6B3229F08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 12:39=E2=80=AFAM Mehul Rao <mehulrao@gmail.com> wrot=
e:
>
> When removing a nexthop from a group, remove_nh_grp_entry() publishes
> the new group via rcu_assign_pointer() then immediately frees the
> removed entry's percpu stats with free_percpu(). However, the
> synchronize_net() grace period in the caller remove_nexthop_from_groups()
> runs after the free. RCU readers that entered before the publish still
> see the old group and can dereference the freed stats via
> nh_grp_entry_stats_inc() -> get_cpu_ptr(nhge->stats), causing a
> use-after-free on percpu memory.
>
> Fix by deferring the free_percpu() until after synchronize_net() in the
> caller. Removed entries are chained via nh_list onto a local deferred
> free list. After the grace period completes and all RCU readers have
> finished, the percpu stats are safely freed.
>
> Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>

SGTM, thanks !

Reviewed-by: Eric Dumazet <edumazet@google.com>

