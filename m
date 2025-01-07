Return-Path: <netdev+bounces-155692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3608A0357D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684F13A3D61
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8B80BFF;
	Tue,  7 Jan 2025 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTBP/CcT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35B7DA7F;
	Tue,  7 Jan 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218400; cv=none; b=HehvRE3e9TaIkHTlKcQdNtZf7xwHEr7g5HDuaTbftWmQCe+BF6UI0eJwzDzRNqPTVXg2X4mpbc93Nt+HHpXhPhpsyCD+VV7F/c+TXNDtVr/6VOYw7JCWotdHAj46aWzfloCg3DuV8EXwJF1IpOgwegdEt8gSIZBZqBHivFvdb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218400; c=relaxed/simple;
	bh=iBDcpPkISOAcPv1cqhwj0C7Cj7kcQnZ64MXQBWYb4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxvAThb0FSKLMLkzJfZcjVG6ELrgMjhmc31I5f01tzswJuejZMbj1R5UKtWSEhSAQOu+6E8jr4pL5neXapm1/hriN2IAMmh8q9niwm4+R+OMILkfHubCXxxkTliOMWbFEK8a2jMdPWlepG1wctB7uwgOEYTP6d5DFjSnNVFs5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTBP/CcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915E1C4CED2;
	Tue,  7 Jan 2025 02:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736218399;
	bh=iBDcpPkISOAcPv1cqhwj0C7Cj7kcQnZ64MXQBWYb4BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jTBP/CcTN6ekv1oNd5XRtZ7vCp7zFtpKGDtbF4Kpm1XZPaZEhyWgQnq7vh/yZ8GBa
	 EOVPJeAD7jE0kt24wo6RVN6bEWONQe3DBNQT+GPaC1KI3BGTH99ZYvqQs++T4DM/Ql
	 XZCc2wX3rE1V+0O68frkLWzx8bzZd5lsROdj/xMC5ElsxYA9yTCu8J2cgcmrP5Qbkh
	 2oE4I3yMzEWsFOf1NgkYcQO6U9J+kEY4fjiWJu7Uuo4XLXJ8JDPnzjXa1ldHGwuNOn
	 vfq92LuQ2lQkeXkvlT25O5CAfhswdKyMNiyTvCFrMsDXjjtmpPQOD0IUwArzlHw6jD
	 qziFQPlDyV2Pw==
Date: Mon, 6 Jan 2025 18:53:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v7 06/10] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <20250106185317.297e099d@kernel.org>
In-Reply-To: <20250103150325.926031-7-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
	<20250103150325.926031-7-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 15:03:21 +0000 Taehee Yoo wrote:
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
> 
> By this patch, hds_threshol is set to the rx-copybreak value.
> But it will be set by `ethtool -G eth0 hds-thresh N`
> in the next patch.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

