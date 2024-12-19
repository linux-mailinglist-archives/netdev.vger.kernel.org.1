Return-Path: <netdev+bounces-153208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BB9F72E3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BCA97A3A23
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D71419A9;
	Thu, 19 Dec 2024 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5UiW6rU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5A132117;
	Thu, 19 Dec 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734576287; cv=none; b=ndOXw6yCTXRfrN3BjTYEHqm8WRclRXVg9nimZIFiHUX3p0xvS/c7/gF6xbkYwcJ7vE6TdZ6+4rrtqaYt48lQ1bEjbQ2SXo5/qCGM8Z1oREs2kuf/zBv20omKuWK7aY2REr84SHEqlVN9F4lghqW+VcxfsBA6IpUXGoQze7w8C18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734576287; c=relaxed/simple;
	bh=FWuyD0b//osOYc5mdv1nNnrcBvI+LR+MMEdxaIjvNUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiP78sUx9yNcFlQCITydH2WXlYSR1liSlYyXZIi+PzRzRs9Le3mWO1xu8+e6mRJm5ShdesbavD+vD42BU2zF3MUu3Pw+pyfY1GHxARrLmVSDLuBgeHZ/i+HUS0h4FexrabRHhV5uwHVHpnV0FNSIWLWLTjUoUJ6WyHv9kP7beC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5UiW6rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71918C4CED7;
	Thu, 19 Dec 2024 02:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734576286;
	bh=FWuyD0b//osOYc5mdv1nNnrcBvI+LR+MMEdxaIjvNUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V5UiW6rUHIdYG0Lz1tF2lysflTmxG57TuP+WnvTnFcT04tHJxUTq78CkIfZ3rCeWw
	 GhWJ3uRRW5JSYdYTmRyUvOCcwz7e4uhEWuEiRNtuPfTj/kbQlwDUoSJIfXLsuK+Shc
	 FbLmZsqiXL/2c+3dsv+Z6ulOawFsWisEw9RWulln407TuYdYXf/9TOJ+/BfIB6EyZ4
	 y70G63W+i7RY8wtqDSdkZoKiDB9wPTpVV/EsYQyjDI/d8HFR3w5GTQWSTlqDxKKbTJ
	 Q/RwJHgT5IWI7DPxeEF++FBgj9PwgH+wKU5BEVMIz53O9kF8K5HxoHYrpIfa4uy9z/
	 n+wVuIe9nKoCQ==
Date: Wed, 18 Dec 2024 18:44:44 -0800
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
 daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v6 8/9] net: disallow setup single buffer XDP
 when tcp-data-split is enabled.
Message-ID: <20241218184444.1e726730@kernel.org>
In-Reply-To: <20241218144530.2963326-9-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-9-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:29 +0000 Taehee Yoo wrote:
> +	     bpf->command == XDP_SETUP_PROG_HW) &&

PROG_HW will be fine, you can drop this part of the check.
HDS is a host feature, if the program is offloaded offload driver
does much more precise geometry validation already.

