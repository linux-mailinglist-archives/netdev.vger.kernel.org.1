Return-Path: <netdev+bounces-118681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13EE95271C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37545B20C77
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03CBEBE;
	Thu, 15 Aug 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDEREAiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3936D
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682509; cv=none; b=tqLCA2xG0j8hPDhbs0xCvbW7L23idXrA5ejfpymstWXO3yuOAy3U3wMrxUOhehhI20oK+ukp2MIQRSvtS4VultuiwRSYFHsGTFmyqOoUWrrLQXw+s5HDptyZ1vZnnlxeo4O8GAycNkTKtNCuurJCCxEZxhTHgqC6zJY0ym1jxTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682509; c=relaxed/simple;
	bh=bu+z5XLj4qyB7v8eXOpPJI3a7tH5ny3jkscek1cbfrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQmIJfNa3cee1bbbjldB5x1dm+10XW+Dt2x5QJa0ZeixeLetou42ZO6MSX9nfWU+1vIPAUy3uHqnytlIkR8GQ0pd6CvHVKE2zEc+V89B8N4zy7H9dDThmn7t6LInX4wpBM7OUNTbLOxcdzBGAYTzkH/bJae6DcrDYXvDhnRDec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDEREAiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F89C116B1;
	Thu, 15 Aug 2024 00:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723682509;
	bh=bu+z5XLj4qyB7v8eXOpPJI3a7tH5ny3jkscek1cbfrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDEREAiN2Tg3IFIoD4gUifECssPjRw/yyqJlU9vUTDgTitbjrvAvq9YKGBvy6yQB0
	 2/wc9iqGgK3iLSx2ezTB3c+PlNxvv/HIqqxUFCLY1HjdcxO6JKKNtkE/Hxt+wpVlIF
	 wTnu7akMXFzdIQA+Xk6sVZahRtmjatm4c+UWqwZO8SfSYc5Xu7knTuVguX40z+v2g+
	 74hRjlCXaMzGy/EBYDO2ThySgrTmRG1XpyU6VFwSgz2rTYqr6/7HBFIe5bAVR7rorh
	 EhVYysjGF99CzqIThQ83josv74vuhlkgg+xpYj5svWp6xRmEqn04IYxNTM9bT2LSHp
	 TzKgLno2K2FKg==
Date: Wed, 14 Aug 2024 17:41:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, vadfed@meta.com, darinzon@amazon.com
Subject: Re: [RFC 0/3] ptp: Add esterror support
Message-ID: <20240814174147.761e1ea7@kernel.org>
In-Reply-To: <20240813125602.155827-1-maciek@machnikowski.net>
References: <20240813125602.155827-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 12:55:59 +0000 Maciek Machnikowski wrote:
> This patch series implements handling of timex esterror field
> by ptp devices.
> 
> Esterror field can be used to return or set the estimated error
> of the clock. This is useful for devices containing a hardware
> clock that is controlled and synchronized internally (such as
> a time card) or when the synchronization is pushed to the embedded
> CPU of a DPU.
> 
> Current implementation of ADJ_ESTERROR can enable pushing
> current offset of the clock calculated by a userspace app
> to the device, which can act upon this information by enabling
> or disabling time-related functions when certain boundaries
> are not met (eg. packet launchtime)

Please do CC people who are working on the VM / PTP / vdso thing,
and time people like tglx. And an implementation for a real device
would be nice to establish attention.

