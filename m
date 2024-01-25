Return-Path: <netdev+bounces-65870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739283C17F
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 13:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DC11C238D4
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2806A33CDB;
	Thu, 25 Jan 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPclyHyy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408B35884
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183975; cv=none; b=k8LJo5MSruGWgVIXEEobGBaCJC+cTgscazhU2yqpgc5TurSVOlcCGxBS3Ggikgxwuu/D2KFiSJl8bxujl7gB5BOFwbxsCYsJ9g3SJEt6PU9uL1scvWbpyHNk+J3xCGcJjPEdC0QXOl8ubIu4QTLTdyKBDgylrcpU6agwxtSP+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183975; c=relaxed/simple;
	bh=s23dJ35CvjO2GLs4pQrm0dyzy7mxAGZCc+mvoDskWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNWgWOSI/4snAkLu4IshM2OHLKeghbBqqEPhJDLxOdIuCDDjnoCTbY5COjNFunwS7Pzx6Uaf0OJZCni9MRI9+05s7VUEP0X0CV1rfwliZepCF5k0VL5ez05Zc3td/wsRJV7RwIPkLrKckLqMR/MS6seBGp1pvN0Nl+hxzYwazcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPclyHyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD4DC433F1;
	Thu, 25 Jan 2024 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706183974;
	bh=s23dJ35CvjO2GLs4pQrm0dyzy7mxAGZCc+mvoDskWpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPclyHyy1qSMFLrfvbLhr2zSNMA65LCs2SoekDzINxCRRmYuDlKgOzER9s9bgiRnu
	 Pm3Te2JT8g7a3EuxxRp/fJBqewgpZ4X8U3jDI0kMpBMmmJ8OX5amPb3iio/CUcBEO6
	 gUjmaYi8uAm3fRB3WUb2gwahelL/npqSOt/Vw7LMnKQsyI/MtjQ/7Av7rmzT5WH+TN
	 TQBo6afXxVIR5GX5R7KZ3GEaENO6krNQxfsdAk3HQn2GLqNUchkb9p4A+ghhS2BzSd
	 x2SDfiL/Iwup2NYX9u6UEMlNVXZocyaoJaaMk6PQC5rlpEYBE90BgE21dwvOW9d4c9
	 w679kjA8PGCfg==
Date: Thu, 25 Jan 2024 11:59:29 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 iwl-next 3/3] igc: Unify filtering rule fields
Message-ID: <20240125115929.GL217708@kernel.org>
References: <20240124085532.58841-1-kurt@linutronix.de>
 <20240124085532.58841-4-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124085532.58841-4-kurt@linutronix.de>

On Wed, Jan 24, 2024 at 09:55:32AM +0100, Kurt Kanzenbach wrote:
> All filtering parameters such as EtherType and VLAN TCI are stored in host
> byte order except for the VLAN EtherType. Unify it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


