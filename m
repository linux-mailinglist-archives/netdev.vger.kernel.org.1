Return-Path: <netdev+bounces-62534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B06D4827B5F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 00:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247C9B22C2F
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD356479;
	Mon,  8 Jan 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDB0P/2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D815254BD7
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 23:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B221C41674;
	Mon,  8 Jan 2024 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704756133;
	bh=crA8XHgqOZT7OEkYYif3LCKS5ysNUNOhBQCamdokaLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KDB0P/2FSjGoOxnBeriBO5b91BLCW5G54tttt/Ft2V1NTDcTnTczGO2XTkQI7sBFt
	 MPkxC0lofNORWX2b3BRe/oS5E7tWyBF4HYLcXTsomHMZDcICoTLrvOQLZ+DFgYDGDy
	 uJL+GwdCa8mKTlgCDVUMqMco5cwCOBN3SBxQX1BwEBgotb17lcHyb6ye93OJ7JHFmQ
	 80zEhUmjDo4CHz/8P+7jZBiD0BT7MQnU1MZCZu6OcOA3OeS6R3gcsuJsGFY0xNV1+W
	 g2BAnuaZ6gLy5mTUAg+Vi/O2PzWq6c6Yu+42XKJyKWDRftD1Pn+/TbcbcvhY/Fo13d
	 /oEr+LzxVWYtw==
Date: Mon, 8 Jan 2024 15:22:12 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Armen Ratner <armeng@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
Message-ID: <ZZyDpJamg9gxDnym@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-16-saeed@kernel.org>
 <dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
 <ZYS7XdqqHi26toTN@x130>
 <20240104144446.1200b436@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240104144446.1200b436@kernel.org>

On 04 Jan 14:44, Jakub Kicinski wrote:
>On Thu, 21 Dec 2023 14:25:33 -0800 Saeed Mahameed wrote:
>> Maybe we should have made it clear here as well, this management PF just
>> exposes a netdev on the embedded ARM that will be used to communicate
>> with the device onboard BMC via NC-SI, so it meant to be used
>> only by standard tools.
>
>How's that different to any other BMC via NC-SI setup?
>NC-SI is supposed to steal packets which were directed to the wire.
>

This is embedded core switchdev setup, there is no PF representor, only
uplink and VF/SF representors, the term management PF is only FW
terminology, since uplink traffic is controlled by the admin, and uplink
interface represents what goes in/out the wire, the current FW architecture
demands that BMC/NCSI traffic goes through a separate PF that is not the
uplink since the uplink rules are managed purely by the eswitch admin.


