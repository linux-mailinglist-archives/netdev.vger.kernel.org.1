Return-Path: <netdev+bounces-57588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A9B813870
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31241C20CC3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C665EC2;
	Thu, 14 Dec 2023 17:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="etSC+Grb"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A18499;
	Thu, 14 Dec 2023 09:25:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702574669; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=IsS9jqdNboH+DokAUmHWqUdAxp2O47MBBHJTb7Dh8wac4DUOZx6ULC2KgjpbCybyXSew3T3QjTNtSSSviySJT2YlYw3WIDIDIK3w+78z2iokrFcqLBobXwVL1ZfGJzb6c8kE1T8RR7SqZZofNhHN5WLHrCVFLUbiYX0kMFBYyqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702574669; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wt/4epX/ikd630E8H32vudYEFiqhHNATnHTpC4Gl3Zw=; 
	b=ZyHXlsU/0eZB83l9Agr4vd5hcci3vL+DaRyfcEEynFd+JkKBbXJyjibopQHAdHthgTBAzu8JQnTVM7JdNnOd4aD7SmUXrFPfI2QC98jEwbHlFavo0k6+5GOY88UCHh9z2V8dVYbGc3ABiiarecKmNL58NKJHEs/cH7QMfdcWNFI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702574669;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wt/4epX/ikd630E8H32vudYEFiqhHNATnHTpC4Gl3Zw=;
	b=etSC+GrbFdDpLBWHJIudygbqtoqUN7XpxfaMwsjjYlbPfUMzayWDO1fyy3AVXh1C
	R9R7xOxYRVhe55/ALgDAvIVatCgtQ/5JTbl0Wqi6J8P36Ucre+efHrFt6NHxNHY0yBx
	0ah92EK14DJOFL1Gxunv4Gis3uvVeg5zdm2mHn/U=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1702574638401587.2154477246745; Thu, 14 Dec 2023 22:53:58 +0530 (IST)
Date: Thu, 14 Dec 2023 22:53:58 +0530
From: Siddh Raman Pant <code@siddh.me>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>,
	"Suman Ghosh" <sumang@marvell.com>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"syzbot+bbe84a4010eeea00982d"
 <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
Message-ID: <18c695b4512.5afde007311004.1718468931473736202@siddh.me>
In-Reply-To: <1813902b-6afc-4539-96b2-050df6fc75c1@linaro.org>
References: <cover.1702404519.git.code@siddh.me>
 <6a26e3b65817bb31cb11c8dde5b1b420071d944e.1702404519.git.code@siddh.me> <1813902b-6afc-4539-96b2-050df6fc75c1@linaro.org>
Subject: Re: [PATCH net-next v5 1/2] nfc: llcp_core: Hold a ref to
 llcp_local->dev when holding a ref to llcp_local
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On Wed, 13 Dec 2023 13:10:16 +0530, Krzysztof Kozlowski wrote:
> > -	if (sk_acceptq_is_full(parent)) {
> > -		reason = LLCP_DM_REJ;
> > -		release_sock(&sock->sk);
> > -		sock_put(&sock->sk);
> > -		goto fail;
> > -	}
> > +	if (sk_acceptq_is_full(parent))
> > +		goto fail_put_sock;
> 
> I would argue that you reshuffle here more code than needed for the fix.
> 
> This should fix only missing dev reference, not reshuffle code. It's a
> bugfix, not cleanup.

So this should not be done? I did it because you told to extend the
cleanup label in v3 discussion.

Thanks,
Siddh

