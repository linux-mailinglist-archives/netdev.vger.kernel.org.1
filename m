Return-Path: <netdev+bounces-66144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0983D7E1
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF21F2CDD8
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF215822D;
	Fri, 26 Jan 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSkYpr7Z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20A59168
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263059; cv=none; b=Fwt2wEkK3jaIJj9+68dICeJyWqcfZ64iUKDe80/DpilPevcoFx0/sM7N/SnwvoNRa9LK7Jwgrmg6p0Cp+3Nab4GXcFk1667rRwtfHQKpZjdcA38SnFrQz2dsuAmmWXZ7v71v6yegXZxcWoZRIfnHEJeqRrPRMBSoL0iSlER6nyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263059; c=relaxed/simple;
	bh=AXNBLxXB8Oyw1ONDCS6Rjw9HVKIt0IqdfKyhiboFtaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTlKsSo4bC93vfLkV4Q7jyjbT4FzKMQECIKjzeOk1x8+GoOZZmFt0cCV8XoTA/4yxHdue2FGccSXwpEzHgFltrQzrq0g6tOtnJZ/stSm2BNELevDpBeAw1RZFX0qV8yksXIFGrnwaeVeXnkVGdMuc+l99V2gwwzeOidRbnNNyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSkYpr7Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706263056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=juudw/dhEZbwB6Hls1nEtxLGmhmoNzuM5TGdeWfuaFk=;
	b=CSkYpr7ZHzHcA+cg8eApSypHLjvPdR7ii4pw1HTR197xwL8uxYyrMFk3FbiE+AfIq1zlFx
	aLondm5kwL6ncoIZC+OTUoArGX8GxseRJZi9tq6Oqoe2HWLO8roMTTVTeRZHEYPdyZC3w6
	MY4q+hb9kGewP3foC7P20OODX7n4CJk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-uzLJEpkqMF6FkWmUS3rh0A-1; Fri, 26 Jan 2024 04:57:34 -0500
X-MC-Unique: uzLJEpkqMF6FkWmUS3rh0A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e4cb5349eso1283915e9.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263053; x=1706867853;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juudw/dhEZbwB6Hls1nEtxLGmhmoNzuM5TGdeWfuaFk=;
        b=Qs9HMc/HIlId2iLRuXSNtSLSQgn8iWRvrItqzmPDV5C1UtPKdMuxG15+WDZadH3NbB
         97n+x1TSCDusdc9yIflGYh+qaz+zgat92gIP70UfOJDaRCtXnGe+xekrtoY2aG1n2pBi
         hY9ZqccuSPbcDAVoXcut93JPnZVxBacicKr5MB4hbmgRbQszdtQYqu/618mKvgWHlJXN
         qM0OUacj7kySbVbyXZ1qDTPhrPph7B6SoAbvfV8WiP0gCW6POWMt2/1IKthpGkDUd63t
         grlaVNJ+cptlSSIKgFEUZM4BanQ3bAMXenwo4on6u/JSn94ewwLvyjVGc3nVGt9cJgNt
         gLuA==
X-Gm-Message-State: AOJu0YzSZCWJ5sZZ6l5JaiiZzb57lrxy0hEsjW4uAj+FEqqMfNiPT8Tg
	FKFM9W1cq6kn9ujEDTihNgUK3Yc1hftOC75lwUEjcI7XpZFf22B6sm1dEeQ+VAnMHOHGFL35qRT
	NxmwKjqH3hhp3atMfL14QMA5mHH1mm01rNXm98P8WeEifU9DXjPOwaQ==
X-Received: by 2002:a05:600c:1c1c:b0:40e:671f:6ad1 with SMTP id j28-20020a05600c1c1c00b0040e671f6ad1mr1421731wms.2.1706263053211;
        Fri, 26 Jan 2024 01:57:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXmtuynSrd6iVAqPhQojK4hh0fPjgsOwxvoxQkj93AK3AkWGXdzoAgYIjyCzmLJfJctoSuIQ==
X-Received: by 2002:a05:600c:1c1c:b0:40e:671f:6ad1 with SMTP id j28-20020a05600c1c1c00b0040e671f6ad1mr1421715wms.2.1706263052858;
        Fri, 26 Jan 2024 01:57:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-68.dyn.eolo.it. [146.241.246.68])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b0040e88fbe051sm5148441wms.48.2024.01.26.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 01:57:32 -0800 (PST)
Message-ID: <e130d1ee30f2800c7afb548683dc1313dc33eb53.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] selftests: bonding: reduce
 garp_test/arp_validate test time
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	 <edumazet@google.com>, Liang Li <liali@redhat.com>
Date: Fri, 26 Jan 2024 10:57:31 +0100
In-Reply-To: <20240124095814.1882509-4-liuhangbin@gmail.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
	 <20240124095814.1882509-4-liuhangbin@gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-24 at 17:58 +0800, Hangbin Liu wrote:
> @@ -276,10 +285,13 @@ garp_test()
>  	active_slave=3D$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].link=
info.info_data.active_slave")
>  	ip -n ${s_ns} link set ${active_slave} down
> =20
> -	exp_num=3D$(echo "${param}" | cut -f6 -d ' ')
> -	sleep $((exp_num + 2))
> +	# wait for active link change
> +	sleep 1

If 'slowwait' would loop around a sub-second sleep, I guess you could
use 'slowwait' here, too.

> =20
> +	exp_num=3D$(echo "${param}" | cut -f6 -d ' ')
>  	active_slave=3D$(cmd_jq "ip -n ${s_ns} -d -j link show bond0" ".[].link=
info.info_data.active_slave")
> +	slowwait_for_counter $((exp_num + 5)) $exp_num \
> +		tc_rule_handle_stats_get "dev s${active_slave#eth} ingress" 101 ".pack=
ets" "-n ${g_ns}"
> =20
>  	# check result
>  	real_num=3D$(tc_rule_handle_stats_get "dev s${active_slave#eth} ingress=
" 101 ".packets" "-n ${g_ns}")
> @@ -296,8 +308,8 @@ garp_test()
>  num_grat_arp()
>  {
>  	local val
> -	for val in 10 20 30 50; do
> -		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify=
_delay 1000"
> +	for val in 10 20 30; do
> +		garp_test "mode active-backup miimon 50 num_grat_arp $val peer_notify_=
delay 500"

Can we reduce 'peer_notify_delay' even further, say to '250' and
preserve the test effectiveness?

Thanks,

Paolo


