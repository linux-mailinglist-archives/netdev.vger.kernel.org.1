Return-Path: <netdev+bounces-83643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F128933D7
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2594283CD8
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782B015622E;
	Sun, 31 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFEB155736
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903211; cv=fail; b=NYp0gtVMnR714cEMo7BbBLIVycNMq0UFP/KyTcE53z7spNJ9vfJwLPRRjIC4ugSjrgm861Ns9Hg5tdiJfTkKDWSPB01R8/DwTo+JD+avuepo6mHTmDyv8znz2bcC3yyaCgRMfyL59An2Ek8RoTXdmxNzJqAokUtNUiXvkWTJ8H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903211; c=relaxed/simple;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8k9CKBvTLeuskJjqsUjJEmjufxe6LOWNFbdWA/utevq/NHPpjgdFOPgG3Lv/NJX+bt5yCosUZxO3dMlRhplWjeKA4oFiRkk4AizGRE6NdRxvFOBVAxrjnUVM+3hHNEZ8sRFstDHD6jFSdYK6BHCQ3KX6cupH0tBF/SNc5vmAoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7k6wgpO; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6B0EC208C0;
	Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zeAm8_4KO44U; Sun, 31 Mar 2024 18:40:07 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 44D91208AC;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 44D91208AC
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 331D5800050;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:01 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <netdev+bounces-83472-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAjUimlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 7464
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83472-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 0EA01200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7k6wgpO"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750086; cv=none; b=oV+q68HQeTF748KBPLD+dQjQdQpb5iJwQh/clFRJnPotjznqr0YLXyt7QSE+T6FgLWGuZRORpSZJrROJfDX8f97NCFff8e/YChchGqZFHLuRmHJBL/QM+5pc4teb6Jwkr130D1Fz+vv8dspH+OqTmcLuBaLOf/zP5w0hiFTWr0s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750086; c=relaxed/simple;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0x6I1P/VLoP8CEBqZPizhsHJAFAxf5EuycvfYcERObgS0DnMShjS06JWH7y6nJ0asvwOgYM/vEoI2pOXKmsGpm29Zsaicn+5kmZq6LbhCJ5/PsnTfTfIjM4H+nPwK5lDNxVpcmDehQrpjXB7PwogkrcOVupvblyNA1PnqIgPMY=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7k6wgpO; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750085;
	bh=kWMETMXKh9pRUAzvZSWq7Bz15B/8zNSH35OZ7BKefWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7k6wgpOpYCMZtcHeZgurRFEn9jwJGxtaPhDeWWiz57ABGohoPp8cFuvxp3seywVT
	 i41cH1D3ebkuoAu6ufLjBgDQYfeitlzDYOUzXDZ3kBiORHqgtYjRP0uJVkR10UB5Ob
	 Lq7Fids2QxfuGxkMzqTUX4/a4sknbiCphzl/eRhmVuUBmF+tlk4qFf5BDiAA/nYn4c
	 5hAcpDR2aXLfShBWguJq/QpgsDd5X28Fd3ALXRVmAb865rwQALLZSqJ/K+PefRhJdO
	 8mTdDVfx1gqowAa5QH0Xx2rfwHeqBnB2HBEaTvME6QONh698m8tTEmNLy4eY9csIG0
	 ZcIa7WOCHRlQQ==
Date: Fri, 29 Mar 2024 15:08:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/4] net: team: rename team to team_core for
 linking
Message-ID: <20240329150804.7189ced3@kernel.org>
In-Reply-To: <20240329082847.1902685-3-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
	<20240329082847.1902685-3-liuhangbin@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 16:28:45 +0800 Hangbin Liu wrote:
> diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
> index 907f54c1f2e3..c13529e011c9 100644
> --- a/Documentation/netlink/specs/team.yaml
> +++ b/Documentation/netlink/specs/team.yaml
> @@ -202,5 +202,3 @@ operations:
>            attributes:
>              - team-ifindex
>              - list-port
> -            - item-port
> -            - attr-port

I think you squashed this into the wrong patch :S
-- 
pw-bot: cr


