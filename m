Return-Path: <netdev+bounces-126128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9C96FEB7
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 02:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA14D1F23520
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B01B85EE;
	Sat,  7 Sep 2024 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxxOj9RK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528236B;
	Sat,  7 Sep 2024 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725669939; cv=none; b=khq8ITqXEGRQIw9YXvlrZtsTbddX/XLPxFGgYCY0MC8+CQizyCWJqoHAodjyIMLlFn+oiBik4j+Tvt6Ex4vbf2A1qvJc/V+S+KlPNNbNNr0ZwetK6gYwdpriP55PM9W7t6eopNbJ4r+cAYaP7+neJS2334X6ziBudtGGruqUAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725669939; c=relaxed/simple;
	bh=Wf9eAQIrgyBOHh+h49EgYiaHCXti2sPJ1vB7JaQZ3es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5lz2aMhlBA8Q2zROGthV9N0c4KUXQhXlybxASzsMvq7rMbzeHouzMuqY/UFfr7sL3nYV/uHEYxq5wjDkCfzGaHxzvVHjk+remzqxrEtNPLRjyaahvVqzJ4ZlqLlHFbHiyDv1/5Cvd4iGAmwjenaagwJrll0mRsgu86jmsX//3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxxOj9RK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F8FC4CEC4;
	Sat,  7 Sep 2024 00:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725669939;
	bh=Wf9eAQIrgyBOHh+h49EgYiaHCXti2sPJ1vB7JaQZ3es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mxxOj9RKxdG8MAveIytoq5zv6qKWAFr4X5GVFqDpMEM8cNi94/S+ykHlfAVoerhFi
	 tViN4liTfBVIU6cGSD2BcHpctYrzw2cAUq1lL0iyWS5UlnJDAG4c6S0Q4n7qGIT1sh
	 hO5s6xDMhK+nVIsBg+Cl0gOIP8ND0WMyimiuIQqlIXXYJDwwIgAoSwH8QPUU7Y5SAP
	 gtx9Qa6oRoANQ9lM12ativ7ukh/snn8bEYpP2v24UzeZBxjfRw4am5E8GrK01nSoD9
	 w4u6OTHroOZ9jqRmeCZ1Biu9203evY77EOKhAyJ8dO9JOi0vbKjJfOcfIAvpeKCFG6
	 cR9d05ZLHXHCA==
Date: Fri, 6 Sep 2024 17:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Serge Semin
 <fancer.lancer@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao
 Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v10 0/7] net: stmmac: FPE via ethtool + tc
Message-ID: <20240906174537.428f8aad@kernel.org>
In-Reply-To: <cover.1725631883.git.0x1207@gmail.com>
References: <cover.1725631883.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 22:30:05 +0800 Furong Xu wrote:
> Move the Frame Preemption(FPE) over to the new standard API which uses
> ethtool-mm/tc-mqprio/tc-taprio.

Please read the guidelines:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h

