Return-Path: <netdev+bounces-169662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B8A45257
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B6166295
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC819C57C;
	Wed, 26 Feb 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8gdGNAQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FD18801A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534060; cv=none; b=ZDlsx9N6p14fv8YVlUA9JnD+Ibqnp06O/AtW9LLXHPlTz/nUGgPtVsWIoUHqldmi3KZScD1iEGDSeinyGb39ZDR8ufBq3V9kLcbd1sUpMK5k9us8tYBaLxRxQ2k3XTJz+0GDSVMvgB8HNpvgXk05at1W9aDFi1IoeK4t3x6EPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534060; c=relaxed/simple;
	bh=1DijM5/Gv5oi/cb5eOw8CNDo7NdzJC94+60awU3zf3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3G4WdgQeS1VSzIcotO6rWI7sUW5rhR5KuFWs8InNDJGOvIH7Bea+wNIRoZu59OLE1UCrP3VykjCNxoEsdm/5Zm+2FJ8Ndphdl5PgXlgp7Ru3RbkQF275+ZQbX2PmAqvYKUhqoECVTDvynCgUArsROz++dF5BQoPaevzlnmOEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8gdGNAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F474C4CEDD;
	Wed, 26 Feb 2025 01:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534059;
	bh=1DijM5/Gv5oi/cb5eOw8CNDo7NdzJC94+60awU3zf3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J8gdGNAQFVis6nAWbeTyDzGeAD8YMYc1dG/76yHGf5cd8/qhdOEYE+rO23O60qXNE
	 btRdP6FL5E+zRzrZcZvf9p2SZYOcjpwpRs07Gv/DWximBtjpQtRmw0usuS5yrpp1aj
	 Xd/YbTz8STJBVq3jAw1NF/cRu39hISq3BG90Bxa+Qqeo/63NUEYYar7mVvfI1dOnL9
	 ZCffCHr/6iwBZ8xccsGqBMcC+v2rjTemwQMPCQ9uX41Ezp4jAAly747PiJO0NDRStv
	 crnStFotvJeBBEqUQDTk1K5QCcLZJ1xW2qdQa9P78+AF8owDOcu9HrFJxcQomZSBUn
	 ZVKqFH2NbLsYw==
Date: Tue, 25 Feb 2025 17:40:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com
Subject: Re: [PATCH net-next v3] eth: fbnic: support TCP segmentation
 offload
Message-ID: <20250225174058.35070885@kernel.org>
In-Reply-To: <Z736uO_DiO1fkn53@LQ3V64L9R2>
References: <20250216174109.2808351-1-kuba@kernel.org>
	<Z736uO_DiO1fkn53@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 12:15:36 -0500 Joe Damato wrote:
> Scanned through this change a few times and nothing obvious stood
> out to me, but I'm not super familiar with this driver (despite
> being CC'd :P):
> 
> Acked-by: Joe Damato <jdamato@fastly.com>

Thanks! get_maintainer sees your acks so it wants to keep CCing you :)

