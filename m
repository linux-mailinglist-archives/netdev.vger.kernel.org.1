Return-Path: <netdev+bounces-124429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FAB96975F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35558282E72
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C862139B5;
	Tue,  3 Sep 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTH1/HHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE681DAC4D
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352827; cv=none; b=CXX9VCtGuApgv7t8BRM289dshcqu6xvscajfTrQqDMyZpeFWbIBkuo8ECP3ZNOxIpXKizNLxgV3iwgNPFGYqN2HCCX4LWTeYzQnCU14OVD9q2z6I0fwMnyyy5FIjgHK13FdmWHLt35bF3jRkejndMzYQ+RJUtceVguYZ6wI3+oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352827; c=relaxed/simple;
	bh=OXvkc6so+UV2+4PiJKCXFlb2kQab8AAEfUjtzHoL/0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKUUSwcTadk0nYd0dwg44hq8iXAWtlquqrtX9e7cMZI1GwgkX3d6LHhpu5YAS9vtOnHT0GkbhyYT0zJShItdjxY4GdnrMHS9gAJjRTnN1K4nPeBknG1M1cvKfC3ZX1q0/ggUZZfitEJi+TNNXKOqA76UkLQqktlD2RsBMhbblO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTH1/HHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB94C4CEC8;
	Tue,  3 Sep 2024 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725352826;
	bh=OXvkc6so+UV2+4PiJKCXFlb2kQab8AAEfUjtzHoL/0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTH1/HHSY6WX2CvMXcRjfgc2v+cGph+5XofxAFFnu8+nwQdsGzfWpblip4iURP/Vj
	 9Bj+cvVxEHt5wbiZEkAu27CUuT8TvvinDWHaxs7Wgfu7JePen5foZysFwAwkmfZiL7
	 Bws1XqzirIofbgcQ9PSe6oYw4Y9wpgTsmNiwIFH8=
Date: Tue, 3 Sep 2024 10:40:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v7 0/3] ptp: ocp: fix serial port information export
Message-ID: <2024090313-crewless-nearly-3ee2@gregkh>
References: <20240829183603.1156671-1-vadfed@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829183603.1156671-1-vadfed@meta.com>

On Thu, Aug 29, 2024 at 11:36:00AM -0700, Vadim Fedorenko wrote:
> Starting v6.8 the serial port subsystem changed the hierarchy of devices
> and symlinks are not working anymore. Previous discussion made it clear
> that the idea of symlinks for tty devices was wrong by design [1].
> This series implements additional attributes to expose the information
> and removes symlinks for tty devices.
> 
> [1] https://lore.kernel.org/netdev/2024060503-subsonic-pupil-bbee@gregkh/
> 
> v6 -> v7:
> - fix issues with applying patches
> v5 -> v6:
> - split conversion to array to separate patch per Jiri's feedback
> - move changelog to cover letter
> v4 -> v5:
> - remove unused variable in ptp_ocp_tty_show
> v3 -> v4:
> - re-organize info printing to use ptp_ocp_tty_port_name()
> - keep uintptr_t to be consistent with other code
> v2 -> v3:
> - replace serial ports definitions with array and enum for index
> - replace pointer math with direct array access
> - nit in documentation spelling
> v1 -> v2:
> - add Documentation/ABI changes
> 
> Vadim Fedorenko (3):
>   ptp: ocp: convert serial ports to array
>   ptp: ocp: adjust sysfs entries to expose tty information
>   docs: ABI: update OCP TimeCard sysfs entries
> 
>  Documentation/ABI/testing/sysfs-timecard |  31 +++--
>  drivers/ptp/ptp_ocp.c                    | 168 ++++++++++++++---------
>  2 files changed, 119 insertions(+), 80 deletions(-)

Thanks for doing this:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

