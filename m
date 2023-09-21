Return-Path: <netdev+bounces-35541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978C77A9C7F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D5A1F215C9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A64D8F1;
	Thu, 21 Sep 2023 18:11:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8C4CFAD;
	Thu, 21 Sep 2023 18:11:27 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF6E8F4A1;
	Thu, 21 Sep 2023 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=UVYX/UF6Q5jgLixkNlvjPTeG0dTbgZSBzEK9p6QYHb8=;
	t=1695318887; x=1696528487; b=b5fIn2YYXhA9TNYJpVt/fc1K3tO5pYZXI7hVxA2wh8ysj4G
	5kZgdnKu+VmDVkqZgeuX8ZhoJ2a4ClXNUoiZfePuejFPROQVTPeZClfgxpipYeB/fRpqikEDxioql
	doTXh5YYioNE1xp4Uh7cfRrTr9YWJBCVlBIHDVh37yDGYRyZQmo9vpsFRAUgEPtQxNgX004Vq1cpL
	gbtjTwrXuHHbt+Npphk0bCSQKJPUPRmORVamSE5t5V1+Gl479p3DCJ79qDKhjaG/vipQNHzLcWX1f
	ARFicvPDwPYTPLrYcxd1I1wywUgO2OxPD8suboS+3avWWFhJRWN3KUG9bQ9ycULA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qjNsw-00DbOk-36;
	Thu, 21 Sep 2023 19:54:43 +0200
Message-ID: <7225922434776cb1a37642e9c828b821da536270.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 3/4] net: drop_monitor: use drop_reason_lookup()
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Date: Thu, 21 Sep 2023 19:54:41 +0200
In-Reply-To: <20230921105129.c6e7e803398d.Idc122c3395bea9652f34ccaa678e918bfd4fae75@changeid>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
	 <20230921105129.c6e7e803398d.Idc122c3395bea9652f34ccaa678e918bfd4fae75@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-09-21 at 10:51 +0200, Johannes Berg wrote:
>=20
> -	if (!list ||
> -	    subsys_reason >=3D list->n_reasons ||
> -	    !list->reasons[subsys_reason] ||
> -	    strlen(list->reasons[subsys_reason]) > NET_DM_MAX_REASON_LEN) {
> -		list =3D rcu_dereference(drop_reasons_by_subsys[SKB_DROP_REASON_SUBSYS=
_CORE]);
> -		subsys_reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
> -	}

Oops, I lost this translation of erroneous ones to the core
SKB_DROP_REASON_NOT_SPECIFIED.

Maybe we should just not have the attribute in that case? But that could
be a different change too.

> -	if (nla_put_string(msg, NET_DM_ATTR_REASON,
> -			   list->reasons[subsys_reason])) {
> +	reason_str =3D drop_reason_lookup(cb->reason);
> +	if (nla_put_string(msg, NET_DM_ATTR_REASON, reason_str)) {
>  		rcu_read_unlock();

johannes

