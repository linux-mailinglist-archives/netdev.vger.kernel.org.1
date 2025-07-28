Return-Path: <netdev+bounces-210418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E983DB132EF
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 04:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE719162869
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D61DC9B1;
	Mon, 28 Jul 2025 02:18:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D51922F01
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753669104; cv=none; b=BaJdRouOufQfMg0mEgMmgxvSiDJe7X7ITTU6qMZcMfuUAvB42576kaIdOhUbJR7nZmHp7SkPMtNAP4mRHuBaXIBrToHnP+6utezugco5tQ06XkX/cd5Sx5N/BlYS/ul8Ko8wCkw2gYEjV3Hb8boOOab+4C3miqeC6rNX76MHzGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753669104; c=relaxed/simple;
	bh=VQwHWX3huXaKK7gRnLahKvYsQk2O/GYo4mZOWCBR0Yk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lvqfnQ6NBxUVgqfzFt5oj9uT6QSqzucr4D24vBD5Hodg0g7jos/0Me/zRboy+Oulcsch9EmWmCIZ1djzf1EqX3y+uxIG+VO+eZiia8WALZoq8MGoc5xhf6nZwpPDFILEDzt2VKy6TVk/oEeqS662AaX8u9VBSGrsgMLttADAAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1753668996t008t34601
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.206.160.83])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 13176386790496497437
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>	<20250724080548.23912-4-jiawenwu@trustnetic.com> <20250725173428.1857c412@kernel.org>
In-Reply-To: <20250725173428.1857c412@kernel.org>
Subject: RE: [PATCH net-next v3 3/3] net: wangxun: support to use adaptive RX coalescing
Date: Mon, 28 Jul 2025 10:15:42 +0800
Message-ID: <058001dbff65$85628e10$9027aa30$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQITOjXVkqWnIM0hpaBM0W0VSPCFxQJ7fTxBASxWEuOzuxRC8A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N6+UlSQllctNsmdl7PA7+LyruTz7ghedJpdb9KIRkOK/MFsEsPhsOkdo
	eq6HRHRtOUPeY673BptfQ7MsgU6dk4/hE9CHgRBhIxby/yBtkg68DEcPSu6Zqrr8IjXiVQ5
	lqYBAJZyXW/M8ehpKL9QOO79NjRSKQyVIjJp6AnDmKXMrwTjgrTCT/3BgSPyCaniJpCvw+I
	4cdHE3dmuAZ2bPL/hiHk2HLlYCWOpAEvbXb0N1k6n75i0e4CDeNB6zJ6wEg/6g0uvY7PD9o
	zKEfcOs3sekz2Hg1ymzVmR+MkOv6sMJbRRXAgfjHhnJrf8Y11NzTVCLc632gmKzNF9mhG68
	zGI+p2D+UAYnVCiHAD4x6srvYUtYr/nxSIa1N4Zv5Mn/TCpAIfZ1Z82mpAhzQIhx8IwH9BS
	oF6GfAWpShLmO/87t4ysWpN83OTNFzUa3gtFaqnOkm3lWK8dSahNFkgPqnfV17RBbQYSoZE
	wAN1AI+aMYCmOr0UpdjCF59k/WXHwLkDSPMTIjmBgJvaQfIJwT/iqIZrmpseao1ia2zydwC
	mqyjFqaJTLwQGfYN81nPCeMqpVElXIZWa6dlCCiQwWUsfCytzWWLt9EkJ8Eu6YJ/R7eoJ7I
	SxBC3Bbbc+6cqgTv0rrVJv8KIyyEIUpmSuP5NGswMBeQg+hVoB4nTfgYyfWf9OBNoaB8JXI
	uOq4si6WGIqg3i4god+j6PDZj13YzMHaVA6E6c/Jp9db1Ksl7ywxTJ1CLirLQLkL7n30Cia
	0EqwFHuh04VnKVJ4Wer96zDe7jrplTkJ4ov9uZq5AsbMAqzBdNRK9lJKpLCQ0cCUaN2UyFk
	jqbaphAOxgg5HRicKV62+BfAjblSpuiSCL+J3SNBST64XfQKgTs+agTGqchTWgEDgCo6ic+
	8eX/Hn2d2Abs2mzFSIKyP3rcGQqAoxsKrR3+8P81T7TA2ybng8LZKEoPgRmQH/u1Jy0T3Ug
	i6Dm6qPYMzInPMvOWICZHmGYjlr1NWvuayTnKslFqk8fhs5cUa0Tn0KwUx9p4Rd5FBqU01+
	3RCwrrkA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Sat, Jul 26, 2025 8:34 AM, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 16:05:48 +0800 Jiawen Wu wrote:
> > Support to turn on/off adaptive RX coalesce. When adaptive RX coalesce
> > is on, use DIM algorithm for a dynamic interrupt moderation.
> 
> you say Rx, and you add Rx as the flag
> 
> > +				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
> 
> so far so good, but then you also have dim instances for Tx ?!

I hope RX and TX can share ITR value, because they share the interrupt.
Once adaptive RX coalesce is on, use the smallest value got from RX sample and TX sample.
If adaptive TX flag is also set, how should I properly set it? Cooperate with RX?

> 
> > +		q_vector->tx.dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;
> 
> > +static void wx_tx_dim_work(struct work_struct *work)
> 
> I don't get it.
> 
> > @@ -363,10 +366,15 @@ int wx_set_coalesce(struct net_device *netdev,
> >  	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
> >  		return -EINVAL;
> >
> > +	if (ec->use_adaptive_rx_coalesce) {
> > +		wx->rx_itr_setting = 1;
> > +		return 0;
> > +	}
> > +
> >  	if (ec->rx_coalesce_usecs > 1)
> >  		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
> >  	else
> > -		wx->rx_itr_setting = ec->rx_coalesce_usecs;
> > +		wx->rx_itr_setting = rx_itr_param;
> 
> looks racy, you should probably cancel the DIM works?
> Otherwise if the work is in flight as the user sets the values
> the work will overwrite user settings.
> --
> pw-bot: cr
> 


