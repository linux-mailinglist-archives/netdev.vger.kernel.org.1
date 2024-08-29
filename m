Return-Path: <netdev+bounces-123527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E31965317
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7331F22154
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1218CC13;
	Thu, 29 Aug 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aICKuXks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF9B18A927
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971325; cv=none; b=bHZ0yqbjeUQhpeSR4bbClprxCBkTcvYh7Ry0TRm7N3zZDK57pERHdIhQvx1OS0vg3OwGl7d0sn7OT9l5LmsfUcnCCFJPYdAq0c8bNfuoac+wuEh0RBRalWdCBwY/q0gH+Z2FkXDpowBmthrOtDZ9NOeeYdq2vxyDPHXwavdg41Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971325; c=relaxed/simple;
	bh=KYCoIUTa6BMWCKcHDzMakcMrg4mkAy+/LLIvmDpsAJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlCb8bghAAcDL787LZWLPY9gefLBMfkeMbYKLAnNQ0TO6Uyu6kmsav3/pDwaY6mc8EZkpxqCwM9xAnqxA6OpMsIskub4fPnLwrvSx3ekwt3b0EBntB+JoURXgwToWmx37rD5RXXYtiXgaUZULx9CWfHwndo0hTeHZfnhv7gGiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aICKuXks; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6200AC4CEC1;
	Thu, 29 Aug 2024 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724971325;
	bh=KYCoIUTa6BMWCKcHDzMakcMrg4mkAy+/LLIvmDpsAJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aICKuXks2Ryb4D9XqK0nFDJdCA/WI2k91mafvg18yqqLA6BvaDbog1pzalOAMooiM
	 jJfCoZm7LDTicvPFBnVl6zfWYf0Flvt0TIbQIsUWmPBHwc2lJXF1DiTUS+9fFjUawr
	 l/uXNp6DKVq7LDEVqkk49ovpIa8Ja+eh2YD+UYAC5d5//8w9Hl99UbZWy3xc13cY1m
	 gTa3Cb3UHzXlzY8HyomAlO6+emh/LUxxSTFXbjHqgd8wbiAC3yzGxm9bOwTj+FIASh
	 FIoGQhzvMIaWg0km4pJ/ocKf2PH6MlVbRumeMUnSrPK7LvTkfXQkp/RIuSLEhPmaXy
	 1yu7j8zmLuPvA==
Date: Thu, 29 Aug 2024 15:42:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, horms@kernel.org, helgaas@kernel.org,
 przemyslaw.kitszel@intel.com, Vikas Gupta <vikas.gupta@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next v4 2/9] bnxt_en: add support for retrieving
 crash dump using ethtool
Message-ID: <20240829154203.1b2d9bd1@kernel.org>
In-Reply-To: <20240828183235.128948-3-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
	<20240828183235.128948-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 11:32:28 -0700 Michael Chan wrote:
> +		if (data_copied + data_len > dump_len)
> +			data_len = dump_len - data_copied;

Let's see how clever the min() police is.

