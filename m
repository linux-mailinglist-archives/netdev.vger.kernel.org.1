Return-Path: <netdev+bounces-196714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD82AD6083
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE6111BC2123
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288482BE7D0;
	Wed, 11 Jun 2025 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/E9TKO8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0321D2BE7CB
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675634; cv=none; b=d6CTA10YrOl5VC7X9PmcOan0WYrxpGWdpWlQG1huB/7I/05NYBi3vFyM852cRm0dYbRGkFHJ9P5/A16sZV19fBo6yQfdNk2KdRCA1Et817BAuLfZ1wFp8aSYmD6W9xceBDo69Ok3+xDgCY5cSGz5W+B5csL3LR+Cfg4FZ4YAGeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675634; c=relaxed/simple;
	bh=f4R8XLe6joZZlREPJ4n8MleSS1a15q2QQWyFBvkEEic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFs5qF7Sz96/FDxfIjkhEU4LjcpKZhaOyR5kx58qqrCg6Y9q3UBjhL7ktYBwwm+o5h2GaXXZeEH+FufkD413PenYDdV4iVGBeOWFaytr+tznYpwEUPzvC0+RZAjbmkClrvaH3BzcUSBW90sTgwMNFkC5mjOSwK/Of+fwk/7v1Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/E9TKO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FECC4CEE3;
	Wed, 11 Jun 2025 21:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749675633;
	bh=f4R8XLe6joZZlREPJ4n8MleSS1a15q2QQWyFBvkEEic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/E9TKO889id5qveOvePyD46n8XIMxvKbj+kf/w6PvKJ9+k+yYpq7jwdVB7HlExp2
	 LS4BVeVuggcBCMBsteiUXHsdkMI/BAER3dVxKwfOvJJG6ZI9t3qKqnFdMpRY4qV7H6
	 taghHE0ASQnk5ylOdvS7xIXT0dqRSc+34KxVWP4FJxsq1NIp34Nlo2uaGLzuSb0qcm
	 QPbngsnX5dQ2vfSPvkhggUyzQHPMMpDV88eI4Kg2EY0f1y9qnCsmtU79B4x+39yZtF
	 dhvoxnavUItDPKqNxwG/qFIfizINX0XrX2erAsWQfAtBFlMN+nIokEl9uYPxtmnPgx
	 FMa/2ZaFxfMzQ==
Date: Wed, 11 Jun 2025 14:00:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
 andrew@lunn.ch, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 3/6] fbnic: Replace 'link_mode' with 'aui'
Message-ID: <20250611140032.1b95633f@kernel.org>
In-Reply-To: <174956708824.2686723.3456558312805136408.stgit@ahduyck-xeon-server.home.arpa>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
	<174956708824.2686723.3456558312805136408.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 07:51:28 -0700 Alexander Duyck wrote:
> -static void fbnic_pcs_get_fw_settings(struct fbnic_dev *fbd)
> +static void fbnic_mac_get_fw_settings(struct fbnic_dev *fbd, u8 *aui, u8 *fec)

We get a transient "unused function" warning on this patch.
Looks like the next patch adds a declaration in the header,
let's do it here to avoid the warning?
-- 
pw-bot: cr

