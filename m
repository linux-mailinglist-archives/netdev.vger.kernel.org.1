Return-Path: <netdev+bounces-269220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMG9Aco8u2lmhQIAu9opvQ
	(envelope-from <netdev+bounces-269220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:01:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 970AF2C400E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FBEB302A1B9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E221D3D2;
	Thu, 19 Mar 2026 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHg2bRed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE140DFD2
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878468; cv=none; b=kRTZ7fx32unimGLqd2Q85N9jjyBcUyDAvoLRld7lUjbrLAYS/DSxmRosv1TntPYdChZANzl2BiawMsaVEv6bW9GI57JtZMiGLXuTKz7hi2nNk/nmONm9uXyRgovhr+fJuVCioKrR5HD5NKhVOILZzEhoOaOUBFOthNVqD554pEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878468; c=relaxed/simple;
	bh=I+jFUSuAOEMjj3fbB1HA6PoT09aFr0BDiTdeapWAWjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntrHxUwb1+1zPC09wHctJy0DWSB4sOS6zb/1NBicFZlPBri81hPFnTOC/ifUPhRYMK4uDvDJND78nakfugWfSMVdikTHfdVhzfRhzxwfKwcKt6fPMBNOxFaP3bUnZ83ueGnEcSTJtfUHdlxZPigUlffvRqn9w7i99CmbAdv14fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHg2bRed; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ca423ad53so580142d50.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773878466; x=1774483266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ILbygoPcRuCSs+r8YFh5aPC+4K7iokiRrlp8YwLSZI=;
        b=iHg2bRed8IOLUzRSEfxP8wWEwl5EK012794uh2tD7rXbk+nFRdNpdoTkyZNeOd/y0v
         ppjF4p9DauAEMn0ap4K+X3hHcHK0IHZGXI3Qz24aleAWSzjroqyJHOOFryZIv6v1McVT
         BNbdSmwX0DKZISvDKXiYyaPdFVcajgVxRdLQ/v3Bg3c0n/pRp9C2v++WmTURksSj/81H
         Ns8NtMB/4OEktleS8I5mBeWOYMgLFGpIigbUM7MfNGGKKfheOl9tN02/hJpwINhTaVaG
         0LOhEZGx0hropxZ4hzFZw0HWF4D7mmM4kX0KcaTJt2lxEkAD1VDwmaL1nVUHWSRi3vbP
         TLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878466; x=1774483266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ILbygoPcRuCSs+r8YFh5aPC+4K7iokiRrlp8YwLSZI=;
        b=MBcmh/Y+7HKKqQVgjjrrNwEnVcFmB2AGg7u3FuKuZ0KotzuKDaWDsN6ncgDbKBjDO9
         AgEzbTsfJGY3aFn19JyWIuu93CCSdAWxKLSBjsx5jLcOFl8+fAQMzY3ojgubQlkdV71N
         rYxrT+QakdhJHZJrA98Cn9QpeaiY8rbLjqOJho3THzh3zSAmW6M/7ge8yNpG4Lgz4w4g
         lIQcx6b7hLg0T47McdXu5vX39q2lcmYfrmxczuAFRA09/+rEVD8KaqNQL1eg45uZCPM2
         KQoPsBl20010nZP9+hXmFncuPHgwuPpxqrSfWfY7Lub3mRTDAAcb4RPjcn5num2UE7e+
         g0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzCeyOM0PKWvxgGwW4RBjAvKgHaijckXBzzTnBn07qYvQecRj1hFtJ0/SXViu2m/yX0zs8bdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzguf52LUp89kGw7IJkbXxXxS72rKA01xsH4jlW3dYBWc4Yidw
	cwZYLHxSS3o5SQedgHPa10r/+PdkrUGwLYQF49X/5iny/lAahoEYymL7
X-Gm-Gg: ATEYQzw7rV+C7JUpjr7bt1bOpmddKC1x8yyD/hnNX/E9mLBLA5KrJdBvr97f2s1yPtl
	fm2o2k2RAMqGoqbp/bzAWH6TNxG3oCHhIZxgAG/k/m0+T0OuEBonAK9IACHTLsYrzMZBSwCh6sc
	LPYsFuU8PXDZdNuMIcJNAyUDhBYdqgQOKj+OVd5TKGhp6ZJVWcHLbTgR09i3ZvUVll2Uel7R9Lt
	2A9monvWHLItt7DGTgP/niJhsw0Mf29ld0od47b5i/v1f/vpT3KNmHIZlmhSFx+AzYFPbbSfmE5
	xc6JlFHhSGbOgKTEtr7EOlHprCoT9C0TsrinQ5Kom1PyN4WWunwEtW2Tv1dJ76yxPDJEPW83Jw3
	kwxSyZlfMMeK6DyXdPgL5VS0Gx2LTPky9MZ4Le8a/h5bFXKHm6PW9bM+oSUEV84f4egL8UvDdv0
	cReMVXgdQCreLLMscYovfaWF0MYzPh8Jejfc9uzSbM3zGYtQ==
X-Received: by 2002:a05:690e:1b66:b0:64a:ec39:dd64 with SMTP id 956f58d0204a3-64e915cbab7mr4173241d50.43.1773878466260;
        Wed, 18 Mar 2026 17:01:06 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91bbecf8sm2512651d50.11.2026.03.18.17.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:01:05 -0700 (PDT)
Date: Wed, 18 Mar 2026 17:01:04 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abs8wCq9PBpuDc5w@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
 <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
 <abq97UD7CHR7bdod@mini-arch>
 <abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
 <20260318161010.2d7338b5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318161010.2d7338b5@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269220-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,fomichev.me,fb.com,davidwei.uk,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.814];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 970AF2C400E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 04:10:10PM -0700, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 09:21:32 -0700 Bobby Eshleman wrote:
> > > > IIUC, we could have main() do something like:
> > > > 
> > > > for env [NetDrvContEnv, NetDrvEpEnv]:
> > > >     with env as cfg:
> > > >         [...]
> > > >         ksft_run(tests, args=(cfg,))
> > > > 
> > > > 
> > > > And then the tests could call helpers that check cfg.netns to use the
> > > > nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> > > > addresses?
> > > > 
> > > > It should be doable if I'm following your drift.  
> > > 
> > > Yeah, yeah, this plus some small changes here and there (to pass your
> > > new -n in the netns mode for example).  
> > 
> > Sounds good, I'll give it a look.
> 
> I haven't actually looked but double check ksft_run can actually 
> be called multiple times. We may have some global state :S

The result is global, but accumulates correctly.

But the tap output doubles:

TAP version 13
1..2
ok 1 devmem.check_nk_rx
ok 2 devmem.check_nk_tx
# Totals: pass:2 ...
TAP version 13
1..4
ok 1 devmem.check_rx
ok 2 devmem.check_tx
ok 3 devmem.check_tx_chunks
ok 4 devmem.check_rx_hds
# Totals: pass:4 ...

Not sure what outside parsing expects yet...

