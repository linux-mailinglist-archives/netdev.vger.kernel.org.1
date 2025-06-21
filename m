Return-Path: <netdev+bounces-199985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5BAE29D2
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9168A1885CDE
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27571E25F2;
	Sat, 21 Jun 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swCugBu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE48101EE
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519429; cv=none; b=igKHmwjgBZSUfSvMMXMvFr8GAweyeQc4c+AAzdA4w2H2c4n6wKOwP8OjKJ4zMs3C+CNXkqvqCLqFMI61NqzTLt5L+FRg73CbC7grW05uYCiwoixP4g1Be9lbYx4m2YTHGaMhvAF8G0qpL2KjP4Gzon/F+/n3pO4xfP9b/mYB1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519429; c=relaxed/simple;
	bh=E0gX23ym1i3tgphLlxpoNk+1/vR5/7QgAzYiDrv9ZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0/wSJsqBIRsXTPBf1Xtb/kaAje51JhSDuawTarhRjtf2i5O8qNf4ojWZPGUFums/aj8NE6ERgsar/cBV+y+VEKvrDOsIiCx//7+NHQ28en7H+7ZJ3H255BEJ+B8fT/unL67s39cWw9NTVCz5dUPssM6UAVP0s6QE0F4lqj2O9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swCugBu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC095C4CEE7;
	Sat, 21 Jun 2025 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519429;
	bh=E0gX23ym1i3tgphLlxpoNk+1/vR5/7QgAzYiDrv9ZEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=swCugBu64YmTiC84TfJELaR/RJh8bjTZNYd+GDmulVByA6jSreH1R3TKfrOqo2e/P
	 TS5Avcxz59GOGWcNWEwdJyWGO2zaacv+GLLOnOJbxx31sAlGABawbPbc6vz8+PJ0jH
	 LcXViGvYd+MP3f78+LnB0AQMMpN/vfUVSmDt0s9QN73YhBCh+k0hSvk/bSgWfJSYaR
	 bt7dTm94l/ZskaaLsvJOoiUWx7zJV29+CKFNUwoa+CXg/jYGijrvj6R2rC/8xEQHN1
	 BGU6nE4zBXw3A6/+bVwYQy+3CcNiwQcfd0b/lMz2X1uhIGJPgDjxhRkai21MwAtaGf
	 PXYlj+WCtLDWw==
Date: Sat, 21 Jun 2025 08:23:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, karol.kolacinski@intel.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next 00/15][pull request] ice: Separate TSPLL from
 PTP and clean up
Message-ID: <20250621082348.32ae3264@kernel.org>
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 10:42:12 -0700 Tony Nguyen wrote:
> Separate TSPLL related functions and definitions from all PTP-related
> files and clean up the code by implementing multiple helpers.

I pulled the first 6

