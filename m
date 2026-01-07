Return-Path: <netdev+bounces-247563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C09CFBB20
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1281303A3D5
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42B2239562;
	Wed,  7 Jan 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBkkaUiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027B190473
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767752368; cv=none; b=QYE+lnt+vYYZfEaFUvUZ5Kj6H7T/GyAOPmQSEuhQUB+h/h4LGs1EhZFZCPJ7gPoetSs783Yl9ZUEcDNjTCNlrsI60LBnxqSb4assnNvy/VBJVvtcGDnSNeIAO+0m8JwYxVrBzs/hkM8YB+tfcxkL8f2uZc+QJzQg03yefl8cumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767752368; c=relaxed/simple;
	bh=IaTD99UxI1gvP3iqLsGRM4oC4hvzuQXUQkvfDmzxJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlZYUHGms2UTSWb1VroaI20FPAUlY6pUnPyh1vbuf6GWfK/j9LYOydI4nxm5nZ5d84dAaU0xJmxi3qOfMRo2h1thcNu7cppZtE0hkkP6fT7O7GZInc8mT+IwDo/Bpg8FIlVnTg1zJ4eLAk0RuHMy0AmeruW3srjJjONrWg5yhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBkkaUiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0856C116C6;
	Wed,  7 Jan 2026 02:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767752368;
	bh=IaTD99UxI1gvP3iqLsGRM4oC4hvzuQXUQkvfDmzxJ+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBkkaUiU7gXFg0kYPFdGdFzSdb5ixHPFZkPgEEuYYJDeUTOkPtRXX0fmWGgxLZntG
	 zLTUKpkMlJ9aJWwtCqrRrlo6EkOpCoO+OkTS4wX+HhofIksOYhTOzWV2S+m5jGs5ct
	 gIRFfvvJaCkGe5Dp5X7+7ifO+vIK9x+iYsOZCBRSIk0VXUVutd44Ej3oLQVuXBNHEy
	 4R7QgnoLdEK37C3gu/DlBWbZnpG6PqNy/NOV3WeMVXnLPNKfrL6Ht390JdEehhvQbc
	 ADsbLe53ZPtd4MPAHa8XKZ+gxilVZ7emwpoSXyFQjFhAyuRYNnCYtbapC7plVnBR15
	 n+mYZqpBOZ4dw==
Date: Tue, 6 Jan 2026 18:19:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next 4/6] bnxt_en: Defrag the NVRAM region when
 resizing UPDATE region fails
Message-ID: <20260106181926.4d561295@kernel.org>
In-Reply-To: <20260105215833.46125-5-michael.chan@broadcom.com>
References: <20260105215833.46125-1-michael.chan@broadcom.com>
	<20260105215833.46125-5-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 13:58:31 -0800 Michael Chan wrote:
> +			if (rc == -ENOSPC) {
> +				if (retry || bnxt_hwrm_nvm_defrag(bp))
> +					break;
> +				retry = true;
> +			}
> +		} while (rc == -ENOSPC && retry);

Since there's an explicit break under rc == ENOSPC + retry
the while loop doesn't need to check retry.
Something needs to be cleaned up here

