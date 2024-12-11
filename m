Return-Path: <netdev+bounces-151016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B2D9EC5E6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362641637B6
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAE1C5F3F;
	Wed, 11 Dec 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Qgz63uUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B01C5CD7
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903259; cv=none; b=hRjsFCxio393ytyPGgN84tEgHJi30g04/1obd6vtXAJaSnvtOkROtBe67aPaAd+tPEijKW0wNQn8koJ2++v9HbNB3z42E1UI8BmMdzJOVQC8NSUcH4g8VQiLJkULeC/NzpOZefWwQrG+FuGpL2TJhISiY6x7GdlIaaBnGarMle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903259; c=relaxed/simple;
	bh=fHz7PloEJF39lwxIrZG6nC654/Zre5S5a967aB1NvhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwxiVUR9nw/eCQPq92yOfL3kU8avAj/UhzFPzHmSyRMBIn+AVHWCuf5sdTMdL0TkXmknQrXMSkIjuF+k4c3e0fUvBymcXsnIMq3Dl8SDo4pUg9gZkUm3zroBHitjivKYqius3++vHybA2Fq2Yxfjg0+GToszxBUY8p/CmmKETOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Qgz63uUQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d2726c0d45so10022071a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903256; x=1734508056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LHyNfPQ7bEUj2B/yNK4qLI/NU2e9BiBcAaBtvQFRjU=;
        b=Qgz63uUQ+FWexj6GnDX6oMmTKjiiRN9+U0F23grp7/jXXarG8sMYejakyrpa4cIhRH
         0zwH/TCBbwMpCDYQy8x40D6JpWBF3wi8PhZW+vCeJT+7tpXB1I00loAej890eJOUC0WP
         xRtKsWJJIa42mRFjF7/Vq3BzzT5rm9TmHvcv7r55iYDZa4qGJJdDHXojT52spdcXAX9M
         M/zkiOmERecbNpiP33OYFRb7YC8d3ZL1D9lUQCdiZ/bjDXi8rQYVwYfqNfk85QWe2dxS
         AlT3I5ipJDlF2t7IzTUK+Sg7YkRZFbaaaMFq/5sYW4tFa9S5KSDBZmHcDDE1K04MF0oQ
         kPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903256; x=1734508056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LHyNfPQ7bEUj2B/yNK4qLI/NU2e9BiBcAaBtvQFRjU=;
        b=UK6N7S2MmytQomOwxdY1YDlwTQNzBNTxUnJT31SY9/lbDgwNXxvFiA5VO441cPk5js
         DMcbG9bquNgz2bINSrIsZ1wdRMe/MGKPt8YJ1KNITD8FmuPNeV73MfwKE7nbGphGgISq
         L8wJ9Xgh2Uw9p/D23K0BN0FGhppXUEH4Mghb8JP64Phd5TOZu6ieik2IbtbUyAllu6bE
         vTGf7o18pzU4nyY8aH//UZAOasfe+sXvdCirU+aH1CffAX3zwVcMvvLKrOpwXZnhkLE7
         uWBMcy9+CLF0Hd4swo+RY+pLmYBh9J+SzaveT1RR8GEeZFoSJoE9/XQNMVhMl8xzO7LT
         YQvA==
X-Forwarded-Encrypted: i=1; AJvYcCVoARXAnjZzLFewqQqgjUsIa3junWeGmlWJBUHtPN+UYQp1IjhdDfveKiva8Yzl4YcdyG2YOR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydRXPSrrR8jZI3NXuhUBG2QPoFRCcfkq95BAFVo7b5DhAMPGa
	hHsAY0g42gQz7DPHG02ycVHw1pP42jgifvv7gbxio0e7DytJb2ESsV8IrPDDSX8=
X-Gm-Gg: ASbGncsm5hJ3tUVfKu6U6soILY6phu4qDsu8iYq/b5GdwxJ+Kwl9Z8iK7R2YyyDJajk
	3DsJqiA+4ZRi2ptW9ESQlXJDuy3WL9QbEODzRuCtQ74N6PlPA95wWy3fFYjt4jVzXp1/sENIuNu
	LC63qdch+5jJr1OIIQPZvnVoVovXfflBYvrgv9+lFAjFbL413zBYx47a95vbSN5GNvmZCBgNylh
	196bzr7725NHOLve8AxJTA+Poa1AqRNxZK0qlIrbnuehGOeWz2mNIdg
X-Google-Smtp-Source: AGHT+IFfGH0YReYOhBvyFJEcHd8lXnfD0NtqwWmh1HLugQVLF+gk8SNPaprDv2+dyCrTabU8iuU8ig==
X-Received: by 2002:a17:907:9555:b0:aa6:a7cb:4b9e with SMTP id a640c23a62f3a-aa6b10d65d8mr144761166b.1.1733903256493;
        Tue, 10 Dec 2024 23:47:36 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa695c3ac07sm343118666b.66.2024.12.10.23.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:47:36 -0800 (PST)
Message-ID: <edd28733-d127-4d92-8d7b-bc111347cd3d@blackwall.org>
Date: Wed, 11 Dec 2024 09:47:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] team: Fix initial vlan_feature set in
 __team_compute_features
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Similarly as with bonding, fix the calculation of vlan_features to reuse
> netdev_base_features() in order derive the set in the same way as
> ndo_fix_features before iterating through the slave devices to refine the
> feature set.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/team/team_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 1df062c67640..306416fc1db0 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -991,13 +991,14 @@ static void team_port_disable(struct team *team,
>  static void __team_compute_features(struct team *team)
>  {
>  	struct team_port *port;
> -	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
> -					  NETIF_F_ALL_FOR_ALL;
> +	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
>  	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
>  	unsigned short max_hard_header_len = ETH_HLEN;
>  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
>  					IFF_XMIT_DST_RELEASE_PERM;
>  
> +	vlan_features = netdev_base_features(vlan_features);
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(port, &team->port_list, list) {
>  		vlan_features = netdev_increment_features(vlan_features,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


