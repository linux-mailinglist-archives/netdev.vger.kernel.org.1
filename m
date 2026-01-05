Return-Path: <netdev+bounces-246943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257CCF28B5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB56F300BA24
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D0328616;
	Mon,  5 Jan 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="I3QajBZk"
X-Original-To: netdev@vger.kernel.org
Received: from sonic309-20.consmr.mail.ne1.yahoo.com (sonic309-20.consmr.mail.ne1.yahoo.com [66.163.184.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79FC328624
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767603346; cv=none; b=TuLouOF5a6Zw83/hBDMP9gtOhYHXEn/yLUrF5Hxel/BI1YrFEjGDcytKIpHtqQfQCAghgJJxCv0g4BDAjtAECwav3TvpnGmURaXd/ybz7h2Lfi1r3MJel2TetaEj1a1NBkGPopWlyd3wlzU4lhcnAACsaQ/KdSI/NX47JMt8rkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767603346; c=relaxed/simple;
	bh=TVRm2t1bsWwkw+ZWDwVzVodoGz1yydSleQuO3POpAf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1NTyqqY73anhxiBo9auBnLQCg6y+A4rxKedRWlGmgVxpJe+q1QH0L5RLx7TY04L9zjJvke8guh4Hnf5Kk0R/YwhQSGIUkr/3scqrmauO/wqDx7t4bGzLIwSGHrmwXTfOwF/HNWW6gtwjKDbAAD8B6LpAQhnsnZes1lKfZFsdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=I3QajBZk; arc=none smtp.client-ip=66.163.184.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767603343; bh=TVRm2t1bsWwkw+ZWDwVzVodoGz1yydSleQuO3POpAf0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=I3QajBZkYYxS4e7xjXxsC/XV3qIAzEX2phKgM3pDMQHMhFBuI5JqGvOBR7r13I5dleokLmFHdxAohUJ5T4Fi7kfA+hVZEcrAGZxd7DOAQUEhuYn88OmXSemu5sGTdSNZwRATrqn154A1kCMmq090lmx0PEcbpfK7RzmWklSNueSvol3xK7N+xfLDa5H3+mCfbPs7yO3J+v3SNElpwu3zKpsnb+vaTpv+A38aUdC/A8i8PjO71gMTxSMb2yobhciL/TQx+rkq6U4Ng2J7Q7pj8QaWTQbSZsXBCEZmjxQL4Yh80vdK1zYCtRerisVBIUTOump/LoB1U3PWrXahpc79UA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767603343; bh=uUxq/rvsWvUAq/g3O5qJutA9Ie3ZCDaBKHz/jvNqmDk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CdERjyFWMibgA879E8qTSOT2fm300Z9Uh/b/QJ1kyVTH46ZFanJT3xwuZ85IBlAHrbKGLIjZgLpaHu5D+iF+2c9tL98wp5BEtM3CdvWK0ci6UBH1TtNmm2RsoYtkfWGzgbMziEZ8gaNxeNXWQxjke6DhVsrekTi8QxIKjni7W7tgZ6AGaBRxfgR1dIiM5DwUEvHW0SX/buNUtKZOgt0gLxxN7jaVzLyIUrj+iKlh9CpKad9r6iEAMW5ek4ErVmuD8geGpv0NlA8ZDlQnS6D6QJJSlFOCQ6iBPJLw0LFmC8amHLXXbDO3YNacWkxlVfauF04j6TXguBRL5hQoaVSl1w==
X-YMail-OSG: Jl8klZ4VM1mkSSQtJHHZA7J.1No8xjNjbATNy1_zSQDalk_Ggwsb8wIycy_lcYU
 Vo9BBa0jxGMCMqN7thcgxv.fgnnNiJU3Gylc6gdgJ1sh174O0ERpn__li06KtqeHIriSmVgW3psm
 8ZhfuOKEKVlEJ5ul_MjqESqfDuCvih74r1kLNhms.GwLbvcaJWYk919Z2SYy4GlFTs7I1wlQLKQc
 0ML9AaklVFFDW1nnNCaUk7ARrnZtoei4QRBhflM98Sa7QapyXSNW9EQMH1BEGQ26HjCIJNL4wNKt
 3huiPjCRrYJ79RxlbjX7rcF._DKuQKyVHK18.DKbJbUXWw8LkNKoPoypmTL0LW1B.T5Dup4fNwLD
 WCqFGbDcCTz9P.fqKpqVpOK8tQ2mhfgK1U4lwMooDqrMbn.zOLpb4y26klCiqD8AnF7WT2BBYh_l
 7hUYDOjP7fIAFa9HJO5WMHUdH2IiBdKY3TiEcXpGzaGqatyOuJEV1Hie6m51gY7PgP5EPS6vLyVP
 4s.Uql6NJlTzduFKwziXBrdZ7jpB7VnHot2fQv0iR_I9pJN__VCcKQbXOdrPe51yIde5uZ4rBRwP
 A7rwLH_2yvS67EIhG2jKHz_k.DBX2tOU3syompo94lvYNO66USruMt88Nzl7XAFOWfPkGJdfNTNT
 9KhoMZsXAIdG9zdMYGl.gW5VJ0KibpTLHzbwKCyd8fomSPhDvC4OMlA9NB8y9GTNay0R4icTcnFm
 qSFihqEglaqEHVr8qraa1.T89eCThGxTXURA0v5aJtmF6zDKJyvCTJiUD2nXt8mMBXxz9.nLj.t9
 eQZHwPhrYtrf3XBSz29Gnea.zY6NB8P00zI7YBgHQBcpZMZEVrNLbjVZ5SY0UKPU9BYaxIYCkaMQ
 4RNio7tWUKzv38Z0UU9T2pemVBQl_jbEZ7VcKtqIM_Ht8elCsyx2e.R_cIxjfpGkLY0GBY6w6sxH
 akivGQoDb31YirRJ.JBTN1jfZaiA34CfXWdAu3xyIdfWh7iXrldq0R.uhB8VFOq.GMQFECmRXAFS
 XafXYE8ePoqa.owODTO7hZmZnqk548nMQRy0ha6Dlkk5S3YjmE0NKsLhmGHSECwFNB97q._4RK7d
 67J4JjDDb79IiXbC4w5hOeJzF8DPO_wr2u1.CIjc.mGBOfEZ3oyczC.ubSKiirrj65z9ZtfkvFNt
 HSXZo2XGviO_eYP5vZ_7QDIegkrLhcbfH8sscSxeKQTybJ7VSlmeYKyEwlVaFtj3c4KCP9YKvACk
 LWJOWeBZN6H60SeNheaAAvR6LILMuC9Zgg6oFpHs5wutJNcKSZt7jcMO96dL80gaTangPExMWkB6
 zuvV6cJ73mzR8jXTJiagbdsBAGW7ZD4MGTPgl6W93gXtaVb1ocrAxcrkDhw9oiB2etD0WObkIu8Q
 0u_EgfBN5_HEfWt4mAe1VDrNwabDmgO6snFs7n58Fb3lDfXApYL5RbgCxb.IPPRHD0Csvw0d8hzQ
 OlFtYfgsTxSarWraC7m1aDqnxmE3hn1uiaDKQBYsazi228_nDLvsSG2bUanH8D1KVYAtEbwmBMTj
 tbfPcdWTWOSanVVyAz6HBKCpcxRVCCL8VfSIyuCiDmbd1jNzIOBxITyKjT1tMBttUQQRvndMKVMm
 .lZd294s9eqVcyjJswXMAoo7mDgEm8RUYy_TLkLMei1Vvfq5ea9mKvSY10itlxFg7EuiXwP2SzAb
 PkItkj50PXekd2QaWFV0KkID1M2Xl59ySxsP5AmNHFU6WcS0CWUzomeOJyCPFOmmxHuMeQ2H1NFm
 Z7la3w0LlbX35DiwML29BNlrTm5E2dml7my6U6El1jMIQr6zOMinIY_7jpn8WbavS4SKpUuVQuGz
 T5ABUkmOWNysCU95J8Oqnoz0UQ1odlkBGYqotHXgDUkg2QIZit15qJ4BOFUQXs31JXd97inXez5.
 0slbA.KgKZKxbwZ9GkpPyfCIgDEYTbATMjD8b_HBDKHhXaXzSJBTfC5RFj9O.UF.8f8lYyXYDDG9
 iTr6jny.74DP2sA6yfZ0JYm5OzrCj.OBVyTGYnVp8N9SkreyLhoZ2um2oZl5w22zntpw3ZM5G2T9
 WaygVE_c7gclQrATyUXicCVYvmk8OdoNkLCCqa8SDnZAREjkQXDyYaZgRI.OcTrQoWSuO85gkETs
 9N3l6EjgMwBGdjNfiML5t2AMH7jkHtBlkecy2RFeYYKKe9N5be71f36EZjY.HSGLw6HyOh9F.QXI
 HFuLVzjnTWydMqyQbfIPIm.vSb5a623VGNr1w1.ck5ih.J1luO86cVYypqBINAwwv7Qn1WniSTG_
 JCLgXZkrK3JSWz6Mszsf8s79ATLM-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 1d84927e-b32d-42a7-8be0-756dc114bdec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 5 Jan 2026 08:55:43 +0000
Received: by hermes--production-ir2-7679c5bc-l7qv7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e9106c643c44c2fe6fe83bec310f0337;
          Mon, 05 Jan 2026 08:35:26 +0000 (UTC)
Message-ID: <03bd5bdb-0885-4871-a307-8a926b1bd484@yahoo.com>
Date: Mon, 5 Jan 2026 09:35:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: dsa: realtek: rtl8365mb: remove ifOutDiscards
 from rx_packets
To: Jakub Kicinski <kuba@kernel.org>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>,
 "olteanv@gmail.com" <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
 <2114795695.8721689.1763312184906@mail.yahoo.com>
 <234545199.8734622.1763313511799@mail.yahoo.com>
 <d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
 <20260104073101.2b3a0baa@kernel.org>
 <1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
 <20260104090132.5b1e676e@kernel.org>
 <09c19b60-a795-4640-90b8-656b3bb3c161@yahoo.com>
 <20260104095242.3b82b332@kernel.org>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260104095242.3b82b332@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

The fix doesn't add any new lines, it just removes the erroneous one.

