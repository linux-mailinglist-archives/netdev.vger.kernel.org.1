Return-Path: <netdev+bounces-104589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC8690D780
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BE5B36356
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7560D21350;
	Tue, 18 Jun 2024 15:28:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FB2C181
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724482; cv=none; b=IHQAWpuJH06m5R9t7O+M66R1eiCmUu0i6z+3pcunfe4ieQSKI8YT8LwZFPmHbxwBnBChrmSw7SYSZj1TS4RrpjpIj+p6jP6akirYU0BFAxKiDoeVXQOo8/gmasVe0w7DeHrdKwUuj8iRsRW0Rh/6IfawHbhhXus4ZseMQOKZ+gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724482; c=relaxed/simple;
	bh=NOknIuZAhqJBPw97XacGFnAcY/rKJc6f+E+R31Ur8X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUsPO8LEuiE439/ZXxgHVsnailHMDFk2C6T10w51kqlMmeXpdmMD2nsqkeFu9X1nwmEsdCwRqXuwNg4iNCNr/bOP0winecvJ9VHl3LiZoLArxap7meLLhiwalbqAfwpCbjUV5dWkzAdjtW58NT83zKdbOFXeOzYXdm7ABP6ZLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=40422 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sJakL-00DdlO-Td; Tue, 18 Jun 2024 17:27:47 +0200
Date: Tue, 18 Jun 2024 17:27:44 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: wujianguo106@163.com, netdev@vger.kernel.org, edumazet@google.com,
	contact@proelbtn.com, dsahern@kernel.org, pabeni@redhat.com,
	Jianguo Wu <wujianguo@chinatelecom.cn>
Subject: Re: [PATCH net v3 0/4] fix NULL dereference trigger by SRv6 with
 netfilter
Message-ID: <ZnGncJD1QprMlP-9@calendula>
References: <20240613094249.32658-1-wujianguo106@163.com>
 <20240618081711.45be1471@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618081711.45be1471@kernel.org>
X-Spam-Score: -1.9 (-)

On Tue, Jun 18, 2024 at 08:17:11AM -0700, Jakub Kicinski wrote:
> On Thu, 13 Jun 2024 17:42:45 +0800 wujianguo106@163.com wrote:
> > v3:
> >  - move the sysctl nf_hooks_lwtunnel into the netfilter core.
> >  - add CONFIG_IP_NF_MATCH_RPFILTER/CONFIG_IP6_NF_MATCH_RPFILTER
> >    into selftest net/config.
> >  - set selftrest scripts file mode to 755.
> > 
> > v2:
> >  - fix commit log.
> >  - add two selftests.
> > 
> > Jianguo Wu (4):
> >   seg6: fix parameter passing when calling NF_HOOK() in End.DX4 and
> >     End.DX6 behaviors
> >   netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
> >   selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
> >   selftests: add selftest for the SRv6 End.DX6 behavior with netfilter
> 
> Hi Pablo!
> 
> FWIW this gained a "Not Applicable" designation in our patchwork,
> I presume from DaveM. So we're expecting you to take it via netfilter.

OK, I will pick up. Thanks for the notice.

