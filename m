Return-Path: <netdev+bounces-69690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D784C2EB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB352B2CFA0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFDADDA1;
	Wed,  7 Feb 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5wV6hmJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FCF9C3
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707275251; cv=none; b=bYkrabAIRrpI3KjEq2Nlmwm7y0YC/WU3em6XSzXajU1OgidGD6p4jvWp7gPuvpm/k40YzJYXyQDeZKbNeupCzfqCHQT4iRP8j3VQ8dmWfPRiZYTivOMWRDrpwoJvAiaQ0WpuwGR1xO/ETEfI6w0GAhJLVpD0eHDLHhTE1Dh5BAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707275251; c=relaxed/simple;
	bh=WRy9wqtzqH4ePQ4ZH6D2TSHCv5oG/MYKPTZI9lWM3Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfwYWA3YXfpdgCZkj4zVDa3jeoximM1bboN3tj2bmG602/BcPX9OmIj+aMlbze19ZA7sLxK6QajkjX2Db5b276qZrVCdl5HmJjnVtvjr+HhZQ3mE23ROmX8zxcyH4Ci5nev+KYICBFTUKdOhktO26FjAww4j0yRxSIYxE7ToYl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5wV6hmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE09AC433F1;
	Wed,  7 Feb 2024 03:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707275251;
	bh=WRy9wqtzqH4ePQ4ZH6D2TSHCv5oG/MYKPTZI9lWM3Q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n5wV6hmJv2ZLloH+YbmoUxTbeBtG3mNf6/01AzRRYw4uLDbcxyLdQSuGhGagSII/h
	 NolXnmWR0mYOd8v/L5oI2dVPbLlssfG4KOsTDJuXJJRnViSkIGW/GuVQzx/gafDTcl
	 UXIVnjtpuN8Z35oy3zZsXzN8UEXUE0ZQiShnttfaeya9UqU5qgBTQnMPlgPKLQEsfF
	 8GwWfrcHEwuzqZ8xTIOTouxV8K/p4787cB0QM1Jk/s9SbG80KzuceRQsuky1kVkoQK
	 jqj2OWUd1GdS/EfEksR1cDvqEXr+rkxtN199zUM2Jy61KqGgK9zUIOIFROsKWoGvc7
	 dBXun9XZVfBLw==
Date: Tue, 6 Feb 2024 19:07:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com
Subject: Re: [patch net] dpll: fix possible deadlock during netlink dump
 operation
Message-ID: <20240206190730.4b8e7692@kernel.org>
In-Reply-To: <20240206125145.354557-1-jiri@resnulli.us>
References: <20240206125145.354557-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 13:51:45 +0100 Jiri Pirko wrote:
>  drivers/dpll/dpll_nl.c      |  4 ----

// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) 
/* Do not edit directly, auto-generated from: */
/*      Documentation/netlink/specs/dpll.yaml */
/* YNL-GEN kernel source */  
-- 
pw-bot: cr

