Return-Path: <netdev+bounces-122212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31941960619
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C02E1B23A02
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6F19D8BE;
	Tue, 27 Aug 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="G2wsmrPv"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB8B19CD08
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751865; cv=none; b=ejltGc3TzIwZmfIXKqquYQX77UMwNkMPJwicFGFexWPjZUm5BQmlLcS+vF9GnKByzkeE9bxA2wRH8X/4c5TO5t8msXwcdvqsrE5KH2wRvPkGVVR3cTYialeLhGXLnsN9AgX+CJiCzYKKgWaHKG7PhtMWb6Yvoca7icopGwBR8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751865; c=relaxed/simple;
	bh=3gXHbRFwhIC6DpvilcDUmMrWHZq4vsdbXzHt0SgqgtQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ml4kJp5wA3hQx505wKQHy7H39F0eW3DVAjyYAYCyphwcFr6huz55CDjp0fF+TjdzZo8NKLMofP13WOQZm+JquudESiU8p1p7nbtXJaNfCpXKQ/SXzz8sozjxbbqAbxjDfWcNHhD5stoXs/GKcFJjIySzFFyyk+xLBPAukIWwBFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=G2wsmrPv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F3A262074B;
	Tue, 27 Aug 2024 11:44:19 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bid6l9mMj1_y; Tue, 27 Aug 2024 11:44:19 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 303D520547;
	Tue, 27 Aug 2024 11:44:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 303D520547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1724751859;
	bh=YyprX3uWH1ZA+PFGRDntqYBaCUbxHBTxxmkYwMV9gPw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=G2wsmrPvtha4FGFKds+Lda69jSx1NS+Z5vKKuVE762hDv3dLUGjbrcPgm95niwVvM
	 WO7sWeVUrKi3fYZ/6cjdo6lxGwxBKFbQ6yxuk0SmdVT74t5CYs1G+jh4/fVehRt/Qd
	 E5AJQpgXztb2HwlkvhcreTWvI167JxSWvnUNhgTwcCS0cN3sJZ16jg30Y/3mGpDOlC
	 2JFFDqGsvVqTgvLdyZ4+xIXOfDWJNvsZ1C4NB/iRVQrjY91yQAigHjuonDWlyXa3HP
	 2CigIXTOwxG0j8JA7QqNi0lKkoiGow92DRJ/E1fUk+PFrywFeqlzjsxQ1ZFnoOS0R/
	 ph4cohRGsi13A==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 11:44:19 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:44:18 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5E1483180C44; Tue, 27 Aug 2024 11:44:18 +0200 (CEST)
Date: Tue, 27 Aug 2024 11:44:18 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>
Subject: Re: [PATCH ipsec-next v10 00/16] Add IP-TFS mode to xfrm
Message-ID: <Zs2f8h7sJYv4jkiq@gauss3.secunet.de>
References: <20240824022054.3788149-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240824022054.3788149-1-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Aug 23, 2024 at 10:20:38PM -0400, Christian Hopps wrote:
> * Summary of Changes:
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate)
> IP-TFS to take advantage of the AGGFRAG ESP payload encapsulation. This
> payload type supports aggregation and fragmentation of the inner IP
> packet stream which in turn yields higher small-packet bandwidth as well
> as reducing MTU/PMTU issues. Congestion control is unimplementated as
> the send rate is demand driven rather than constant.
> 
> In order to allow loading this fucntionality as a module a set of
> callbacks xfrm_mode_cbs has been added to xfrm as well.

I consider to apply this version to ipsec-next if we don't
get further review in the next days. Do reviewers and
testers of previous versions want to add some tags before
that?

