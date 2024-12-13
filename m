Return-Path: <netdev+bounces-151721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210EB9F0BB1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEBB164444
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159921DEFD9;
	Fri, 13 Dec 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESq6JEwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC81DE3C4
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734090883; cv=none; b=nSSiAtaBO27Qwy7d1PordxJ19jH7HUOJP1EHABb21NJzjQ5MNRGwPLDuPff1+0yDfxvFvY+lYn03zrXVKv+pOtzW3ZLnn7FHiygD/y6M0WFv4AXQgeZfEOWGKWZJHs4RqY7HY7kLsDH//nqimen7BCbxlNiX2QTabrswSql+gvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734090883; c=relaxed/simple;
	bh=nEQGTQHmIQhO0/A9uStQC/R0spmJDZztIzVtIEjRsyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaOF6y0eLRFlP2j2ZYHaXcRv0PYBVGGtKbflIfDXmnZhwsuMQS4ZOLduetY1A4BafV+PlfP58CaL14fSuNGBD3sK54xXZ+Z+L/IGlno1FTIgib2vQhqpx90Os/I1ZfVaVZtVvlOoQJovkg3UB/7oUl56GVrnirfk9fhAPdesDWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESq6JEwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE190C4CED0;
	Fri, 13 Dec 2024 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734090882;
	bh=nEQGTQHmIQhO0/A9uStQC/R0spmJDZztIzVtIEjRsyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESq6JEwktjriu1cljx3tf9sSHX+DDhg+Qm0bpw3zow1aJBEt9S/PWnlnint+AwgJG
	 q8EI0fw4oTVEGvLMGAkjP2H7LwmMALFLMolYlZGeuopTmtaypJCBNt8jM7eTuj56Ih
	 Ufs+Y8krPM6aSK8wSiRBkGmIHZpRFDCZfSfUC4q26wHfm3t+UTpzdQPci3i0pVmESZ
	 EdW4G6baxNiCi+smBSpGKfhrUFKuAMtk6HHwAvp9UsEtVal7xTWKeHiM/zUF2TLuP4
	 xJK9Ml6ZhO8pcA1YA3pBlWMTtrLuBDD1wmtjUiOxxmVIeQuJTw39JK7orudUwBHiwr
	 QZcFzfEn5R34w==
Date: Fri, 13 Dec 2024 11:54:38 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>
Subject: Re: [PATCH iwl-next 2/3] ice: lower the latency of GNSS reads
Message-ID: <20241213115438.GP2110@kernel.org>
References: <20241212153417.165919-1-mschmidt@redhat.com>
 <20241212153417.165919-3-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153417.165919-3-mschmidt@redhat.com>

On Thu, Dec 12, 2024 at 04:34:16PM +0100, Michal Schmidt wrote:
> The E810 is connected to the u-blox GNSS module over I2C. The ice driver
> periodically (every ~20ms) sends AdminQ commands to poll the u-blox for
> available data. Most of the time, there's no data. When the u-blox
> finally responds that data is available, usually it's around 800 bytes.
> It can be more or less, depending on how many NMEA messages were
> configured using ubxtool. ice then proceeds to read all the data.
> AdminQ and I2C are slow. The reading is performed in chunks of 15 bytes.
> ice reads all of the data before passing it to the kernel GNSS subsystem
> and onwards to userspace.
> 
> Improve the NMEA message receiving latency. Pass each 15-bytes chunk to
> userspace as soon as it's received.
> 
> Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


