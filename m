Return-Path: <netdev+bounces-95940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CD8C3E31
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86DC11C2124C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC76148833;
	Mon, 13 May 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+CtQTIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC314882F
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592895; cv=none; b=Ae+6Wq2KQHqCTOuXmtsq6rW7R8ck3hPR5vjB3+l508NWUi21V/cyZfsAJ4tWmbD7j9T+GydHmptwnMJjbHksX98JGG0sKmCKskkvJ5gmd0mr7CnUVQdp+b6MiC5WXBCx6E/feSGwb3FOBkuG4/QNU5P1HdUkS3LfpAlT5/Yf6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592895; c=relaxed/simple;
	bh=tWwQC9M8EHvCUvKMe50cRr/DkY3YfRhEBqJ1F+rNlEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHqc54RdguAfeJF1qJSc/H2daOo2wexKp1+aV6MUo8JdonuuDNNshP7k0rsri2q3cyK6dtQr43eRZ46RuyrB4DGx3H67XLYSo84/GAY8p02ZuwN4+jTW3OylFPeKfl6bbk4Thp8LSKDZp0Ql58T3u+GRK1Qvy60B2oRG3OMvpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+CtQTIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4F1C32786;
	Mon, 13 May 2024 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592895;
	bh=tWwQC9M8EHvCUvKMe50cRr/DkY3YfRhEBqJ1F+rNlEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+CtQTIwYbrntDqE/hMfaogOA9pZojilLZcMd0zrzOKMdM05QHsGeraMcNIDgcsnn
	 uDy8hn9YZ8NisHFsMHxmHdmiTsH6R1PV2zpn8jMhWuFoznbfZWk7QC3GaN92EflS1t
	 kQAqUtTzHTwrfprrP3/2BfkFaCUX02QznOPqrjbveZl/xlHRATP0kH5FRC8j4XJI6d
	 YOZtNpKM46luhyi4CrrCREFmNAmzTLM3UP4NTVHPNHi8ZlfdS1Ug9AifMZki8uNSY4
	 QBt/DqdLsGIPKxCKOS4Y5kBY5FTl4jx/corhOFDvbJ8954RuTvN5NdZHhYY/RMdIgT
	 ZmyAuHgLu5Rzg==
Date: Mon, 13 May 2024 10:34:48 +0100
From: Simon Horman <horms@kernel.org>
To: darinzon@amazon.com
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v2 net-next 3/5] net: ena: Add validation for completion
 descriptors consistency
Message-ID: <20240513093448.GG2787@kernel.org>
References: <20240512134637.25299-1-darinzon@amazon.com>
 <20240512134637.25299-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512134637.25299-4-darinzon@amazon.com>

On Sun, May 12, 2024 at 01:46:35PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> Validate that `first` flag is set only for the first
> descriptor in multi-buffer packets.
> In case of an invalid descriptor, a reset will occur.
> A new reset reason for RX data corruption has been added.
> 
> Signed-off-by: Shahar Itzko <itzko@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


