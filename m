Return-Path: <netdev+bounces-229681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78FBDFA9A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DBC74E547E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E282B2F7AAC;
	Wed, 15 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyQfhI81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4560205AB6;
	Wed, 15 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545918; cv=none; b=RhgGGzicslwt0u18fYk6jCc/j0Oae5Z1rGnH0PhzO6edMEmhex2EangBKy6/xREUTZgYA/HtLsXM6tjcHDwXi9ePnuueHGvZYPCEuhYSZpeqxYCO7GuBXOYZe7PxrJVP9WCJiHpEg/NMVdocbCQ9xleCAWU4KaL4iKem0XEQ0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545918; c=relaxed/simple;
	bh=BDBgHqGKg8kxASakOnsE9eu2W0NBeHR9L7btp+ec49k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTVGKqxHb46MhKlbhtaA6C8FcgnKfJqHnJQo8ewImhBHn9c4rvbQ1XPyV2KLXkPil2V7p/295c3+6D350X/dJFRpggN0Hw2oDvZ8gHWGh5qtqa1Oj0hUMXssukxdpYPqGI70NquuBe4cwD0ROmVkSn2YWZwgoYWbiD4K4ApMb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyQfhI81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF2CC4CEF8;
	Wed, 15 Oct 2025 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760545918;
	bh=BDBgHqGKg8kxASakOnsE9eu2W0NBeHR9L7btp+ec49k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyQfhI81TQhBnjopIRKsT6OpIuahtU9FssuD/WqoqsswyzKW6JnWA+xQc757bJQeW
	 e2brIY6CGQ5WYCVpyLd2XMQoXcU3RTDWB2MP282SIip/+mUz1ZPQvubWMKfhRmc0rX
	 Fi8MrcjB7zgmmki2Qs5Df8WywUwqUoFk8vRbRXRgutVC1OoAZw4bNu59UMyRN/Nf+9
	 e9pAznvqX6zMoE0ZS7jo5Y7ehmbyqoadfzcXkI11Y0OmUJymVtaoCNImp9T2HdDsK6
	 +9ksMjXgzkz9nX/Q/TtT/wvQdaZfdojKymCaEUaYQjn7ZIZAqcpOWFZmi1Kv9z2GyZ
	 No774+bwlAO6Q==
Date: Wed, 15 Oct 2025 17:31:53 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Subject: Re: [PATCH net] net: rmnet: Fix checksum offload header v5 and
 aggregation packet formatting
Message-ID: <aO_MefPIlQQrCU3j@horms.kernel.org>
References: <20251015092540.32282-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015092540.32282-2-bagasdotme@gmail.com>

On Wed, Oct 15, 2025 at 04:25:41PM +0700, Bagas Sanjaya wrote:
> Packet format for checksum offload header v5 and aggregation, and header
> type table for the former, are shown in normal paragraphs instead.
> 
> Use appropriate markup.
> 
> Fixes: 710b797cf61b ("docs: networking: Add documentation for MAPv5")
> Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks Bagas,

I agree these are all good improvements.

I would like to add the following, which I noticed during review, for your
consideration.

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 6877a3260582..b532128ee709 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -27,7 +27,8 @@ these MAP frames and send them to appropriate PDN's.
 2. Packet format
 ================

-a. MAP packet v1 (data / control)
+A. MAP packet v1 (data / control)
+---------------------------------

 MAP header fields are in big endian format.

@@ -53,7 +54,8 @@ Multiplexer ID is to indicate the PDN on which data has to be sent.
 Payload length includes the padding length but does not include MAP header
 length.

-b. Map packet v4 (data / control)
+B. Map packet v4 (data / control)
+---------------------------------

 MAP header fields are in big endian format.

@@ -80,7 +82,7 @@ Payload length includes the padding length but does not include MAP header
 length.

 Checksum offload header, has the information about the checksum processing done
-by the hardware.Checksum offload header fields are in big endian format.
+by the hardware. Checksum offload header fields are in big endian format.

 Packet format::

@@ -106,7 +108,8 @@ over which checksum is computed.

 Checksum value, indicates the checksum computed.

-c. MAP packet v5 (data / control)
+C. MAP packet v5 (data / control)
+---------------------------------

 MAP header fields are in big endian format.

@@ -133,7 +136,8 @@ Multiplexer ID is to indicate the PDN on which data has to be sent.
 Payload length includes the padding length but does not include MAP header
 length.

-d. Checksum offload header v5
+D. Checksum offload header v5
+-----------------------------

 Checksum offload header fields are in big endian format.

@@ -158,7 +162,10 @@ indicates that the calculated packet checksum is invalid.

 Reserved bits must be zero when sent and ignored when received.

-e. MAP packet v1/v5 (command specific)::
+E. MAP packet v1/v5 (command specific)
+--------------------------------------
+
+Packet format::

     Bit             0             1         2-7      8 - 15           16 - 31
     Function   Command         Reserved     Pad   Multiplexer ID    Payload length
@@ -169,7 +176,7 @@ e. MAP packet v1/v5 (command specific)::
     Bit          96 - 127
     Function   Command data

-Command 1 indicates disabling flow while 2 is enabling flow
+Command 1 indicates disabling flow while 2 enables flow.

 Command types

@@ -180,7 +187,8 @@ Command types
 3 is for error during processing of commands
 = ==========================================

-f. Aggregation
+F. Aggregation
+--------------

 Aggregation is multiple MAP packets (can be data or command) delivered to
 rmnet in a single linear skb. rmnet will process the individual


