Return-Path: <netdev+bounces-215866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFA2B30AB5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AC11D03EF7
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 01:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CAE81732;
	Fri, 22 Aug 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNeWSUT4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F96393DE0;
	Fri, 22 Aug 2025 01:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825532; cv=none; b=mOrrBuHvfuDq92WsVrE+x1wxW/UjZG9EiFvnP7+AipJIR8KO/AtCUjTGfUXjymBR9za/bUoYpLgOpWGcZMf2Ang/dGMUbqFPqMmRmBV6biWx9SdNHzCfKdVZcZl2u0iAonCUC0I9zAzbsVCUbWk9erW+BoCsjZsARwrB1X91E90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825532; c=relaxed/simple;
	bh=EmGmH/AKGIUC0sHj6WLzucn/g66akuiKWcitfVn6KlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SypL9QZ0U1iY/t2Wwv65KYtAi2latb2ujklHL9aZURfV1ltVd6B/YNBssHZwTt/J6KTYJJhCyvygazZ9q+KgaW9Ve4AJVIHoBhKlEnJ9S7lOtV+n0wDaKmHhPRDR2sXEJ5DXRkkhYdtOkE/0gn5rlz6oO5jqVDdQfsjrywEOuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNeWSUT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10207C4CEEB;
	Fri, 22 Aug 2025 01:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755825531;
	bh=EmGmH/AKGIUC0sHj6WLzucn/g66akuiKWcitfVn6KlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DNeWSUT4LGlCoSQnqDIYfRF9/x5S/DF7Trd2ud08U8Q4Lpo2/BoLUF5PCswoDwBpu
	 U26ZWgtkwo4e//80+64aWp7z/M/FM/uLSJDHxirx9CzoSdLkkv21tj/ueKvQwmYgc3
	 C/5FQfhIWMZ/ZHhN6t1UcZES5JW5wjUaFVeDn/S8es1chvjar4YsgsCJng/9Xu1JhS
	 ommArwX8V+M+HrRSsC3UqNpEA0z5Zo2jozokZffmjVftEkNxQjr26LnQGIj1w75c9c
	 47KXZpZVA7cydF2kJU5YpEv/wWMACZxIDlbEhjOQftDCEyGi52w9OwRhYpHx7KXBkQ
	 FqXrUd8MGY6AQ==
Date: Thu, 21 Aug 2025 18:18:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>, Matthias
 Schiffer <matthias.schiffer@ew.tq-group.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v3] phy: ti: gmii-sel: Always write the RGMII ID setting
Message-ID: <20250821181850.6af0ff7f@kernel.org>
In-Reply-To: <20250819065622.1019537-1-mwalle@kernel.org>
References: <20250819065622.1019537-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 08:56:22 +0200 Michael Walle wrote:
> v3:
>  - simplify the logic. Thanks Matthias.
>  - reworded the commit message

This was set to Not Applicable in our patchwork, IDK why.
Could you resend?

