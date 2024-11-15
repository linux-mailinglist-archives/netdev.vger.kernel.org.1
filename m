Return-Path: <netdev+bounces-145174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30869CD60E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 05:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7361F225AA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DECD7346D;
	Fri, 15 Nov 2024 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HldpKs+O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA92F37
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643222; cv=none; b=K/dk1IwmtILMGk4dkStT/tQaV4bK6rC7Ft8bcUfDNBL2NRNn/QL8xI8VLviXyv2dyQXPwLvRBjSO/pZH/GamsR6r1KAjHJ28CNFdhL7NGVPKoBJI2R9CAwUi1azyL7zikD0SuXx+zlWihPNjc9oc39MNyCYpTEhA9i+bU/AJ2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643222; c=relaxed/simple;
	bh=FiVivVTHbv/u5bN8W/BgNqkJse+EPl0+4VcAf7Q70uY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsUhCYuSDAZ58Q0VX7SmkyuY8+sqUeFFHv/kJ/1PESeFhjLvHMsaSw9sDv3Sta/+hHlr885GYHU+Mu92Mg4Qek3v1N0Po3HwMByWmqSe45pyWhBeABsqipzYybQgG1uB3xtsVP10zx9QlFgxBiB5114Xf1SksfekE3nL/sFu+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HldpKs+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6285BC4CECF;
	Fri, 15 Nov 2024 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731643220;
	bh=FiVivVTHbv/u5bN8W/BgNqkJse+EPl0+4VcAf7Q70uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HldpKs+OccoH5GwvshU5iY4OeYlWlkVKyd5oq4JLNLUSvlftErxJfykoP5wze+CgC
	 sJTs4JjTMp0Y/PkhEnsEfmprSDv0XRgtJc9mzZ6reQCcUh97egds64iejmZ4mXDYbH
	 qoMbvs6cgNBnTME6cJ4Wxxmyuo0+C+dVcLXgsNdP0jhMKgs2/wZjVhyK+zuLo3W/Xp
	 UclHqNhG8BnBcXwsBgEH15LxRi7d9ZFOaif9nxye091erlahBDvNmhLZpJXOhARFTP
	 kCE9b9LHI7+3jeTTALaib+nyvl8Dmt2LBGOeq/QYN74ypez8i4kHsacSwe0cuDgLox
	 Tp1+US9Q/ijzg==
Date: Thu, 14 Nov 2024 20:00:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, andrew.gospodarek@broadcom.com,
 hongguang.gao@broadcom.com, shruti.parab@broadcom.com
Subject: Re: [PATCH net-next 06/11] bnxt_en: Manage the FW trace context
 memory
Message-ID: <20241114200019.0ae1fb61@kernel.org>
In-Reply-To: <20241113053649.405407-7-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
	<20241113053649.405407-7-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 21:36:44 -0800 Michael Chan wrote:
> +	(((data2) & ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA2_CURRENT_BUFFER_OFFSET_MASK) >>\

Sorry but 70 character name is not sane.

