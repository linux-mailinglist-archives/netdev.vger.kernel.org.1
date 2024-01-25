Return-Path: <netdev+bounces-65993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADF883CD1E
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF6A1C22C61
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04430136643;
	Thu, 25 Jan 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k05zkkw3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334B2135A45;
	Thu, 25 Jan 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213273; cv=none; b=Yv1e45t8wFcbxw/vvE4gn/92XG4RNfrRwZWjMaLCFFODuC8Hi4HjkRrU/3AgqfKY4iVmNip2u52qn3da7+kcbwP5Xl7X84p4RDq/C+0tcOF7pwhK55ODQlg5hhCGZmXE9nZ7gTiYIq6XyL0yHhnSUoq73vvbkDWLjZ+g0fl8rMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213273; c=relaxed/simple;
	bh=W/2Siwvqu0TIYxIevTR0TX66dRDvNeV8PC1Kqf/dVuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nztkIu2YTneQacoKY2lwUFi0NLJZTcS6MGJUrIGRDuNigZMVSGs5kPqe8U4G/SnVqqdpEZmdx+Dj8d2ogVf5kCaulFEPAYdPX2SZGU62UHw7zXLhlFGwANjlgvMnQYDzlNEoqfxDNyWWR4QJKn0p2TISUNBG3ItYC+DihunN1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k05zkkw3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LW+QZV+rygeD0sv1VLqkKfoFCIbEkVehTAuF0y4Mzf0=; b=k05zkkw3S8y2+XaH16PdhECRwD
	Fwv0+wYcso4YDHVz6GZoqd8N7ZrCpJL/pdzsoSWTPD130UWlZRbVv+Xavlv+uQo1ukr+Je1QIBxHW
	YCUsA7CRtkeuCJ1ebg6hI7MPmVNNopjccE4d6BHlbObcxHsX+jjwRRRdrRTktIdwB2Ss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT60n-0067Nq-PN; Thu, 25 Jan 2024 21:07:45 +0100
Date: Thu, 25 Jan 2024 21:07:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 3/8] dt-bindings: clock: ipq5332: add definition for
 GPLL0_OUT_AUX clock
Message-ID: <b939445e-c0a8-48fd-bc95-25c4f22e1e0d@lunn.ch>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-3-19fa30019770@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-ipq5332-nsscc-v4-3-19fa30019770@quicinc.com>

On Mon, Jan 22, 2024 at 11:26:59AM +0530, Kathiravan Thirumoorthy wrote:
> Add the definition for GPLL0_OUT_AUX clock.

The commit message should answer the question "Why?". Why are you
adding this clock? What consumes it?

       Andrew

