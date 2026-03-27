Return-Path: <netdev+bounces-272351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAupGV74xWkjEwUAu9opvQ
	(envelope-from <netdev+bounces-272351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:24:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465A33EC84
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39F8D30131D9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E336A014;
	Fri, 27 Mar 2026 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya59lGXm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tH8xcEAl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219C35B12B
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774581758; cv=pass; b=e+3GiwWDcuYHWES/DItdJcp2J1qWyi/WsNmbH7tJA/StAd/pWrakEYVdpEKpFbLIAW/FKPn5JmSTttxu/73BySlAx09jbLlmKMvP7RxbYRT9eS2ofhbKnhOlWu9qEO3OMPNbH99nXXeSI6+FH87K86YjZsbsZZ51pBne2TuAmXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774581758; c=relaxed/simple;
	bh=m1mIuwXXzdAaR32dcGiWLRmK4DBpjIpyB0UUnbvcEc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1dWQ+a6SMwaCsrb/BOqNOs2hpwgkObKcrkFMccnPYWLyYj1zhaVALyXr4IRlbdbpVaZjdXcGOBDGEEEwmuJUlExOoPnLMyluK0etTEHHvEoYtaM9h9sx3ikjo39aENxL4mMzPHD8ZZr+Ce5GzWRV2SJxxzgKRSdkHLdd12XDRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya59lGXm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tH8xcEAl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774581756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
	b=Ya59lGXmtb56JX4nTT3bsB54zeisejXIggD3j6iCqp7LLn9VjDOUBcqlU9oPRyo1n3Y34K
	dfaN7H7sZBK+OJNakpnHSDohdQhRcQhjwFFTVomrhlEz/HSoSvlfiMnE7SeWcH1cgRmlvA
	Sd0PVmDm3CWignKYl6AKm4KOSa06ayQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sVSxaM-BODuILVqEJdw1EA-1; Thu, 26 Mar 2026 23:22:34 -0400
X-MC-Unique: sVSxaM-BODuILVqEJdw1EA-1
X-Mimecast-MFC-AGG-ID: sVSxaM-BODuILVqEJdw1EA_1774581754
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-359fe4e9ea7so1422694a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774581754; cv=none;
        d=google.com; s=arc-20240605;
        b=F7nWfiO70aqkG4RATPSBbv/vTSTSJNRBZblyeeqMD/dP4N9JTOKE5G/n4rhTz89fYU
         qbRwvlkmRPkD5j9oepvMgN2jCFhV/4/19vzpIqaz4AVy/Cb3fhn9Tx2kT+jbGeHHJlF3
         3F84hpXkDsF/CT4Xy4uyJbtZpko5cGhjAbSF0bx2vYI9vQNE1Cl8Qg5IivB24K/aZv8w
         QBff0Q5YngNaVMTfFspgWev7ItFbZydMq8L+hM0x6bKnsH4AF8ffVSZGCVjJr70FGMXs
         zfin8f5Hrpb1Zn13BOLGM8Q074Zp/+UCJe2GwKZ4PbmeoSMcjrETjzpbJBfYx8GFXcnF
         lzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
        fh=yyx+rgJHgqCgkGrDPzsiIIWbkGkjdWfGCnyTukVUZpY=;
        b=XiYWjFtsp6syHc7zNVlTHIp6LlIJTchOumNCt36iPcWxjs2nM2xm4ndXl1xqGd1ITY
         avNUUb+7VDh1X02yCyeoYdGXgNg0t2ISS61M2YdxZowonWRr2TsY1keG7dU1F2WgsBf+
         GuWgxICpJuQQXhIe8As7GyHCDjLFcW6z2tmvYduOfZcprJLW3gJX9mb5rcvSALEm0WN0
         pO5dVQ/FQuR+0C67BoQYFgc7n1v+pGoY7U5JnXR/1kydejs38UGNaB+1W83iqqKcNVia
         ZhhsD69KarqZqcyMDF3oTajseZJAX7+I8K6l3eDKmpgb6jCv1L3/knNeO9bo5FrG5mzG
         +UfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774581754; x=1775186554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
        b=tH8xcEAllvpZRSQR6ERJJDdZYf269l0qE8Yn3WxcPOCVOuYb8dnuxrwO2W6qKp/+cs
         OXYSLvIK50xmC205Q+oRA3vzjLoUk9wT/7yReyoT74XCUwqpyRYWDqHOy7WPIyhIIM5e
         TqIP6PJvGlizToXXl83iTMvqPMNBZcjCgqFAAZyWdvaNtKyBzxKsnU3lEHn9H4kWju0o
         QW5WZv0eyzO8mZmZ0G1AqglCFXrOcw6g3Jpd3VcnMzq4YsQ13BW9QxSsuBjWjGIk8uGL
         XmPn4pYPKNPu6JVy9FQdRzVPLpv6FjfopVowIXNlJ9yx+bnfOsCuWh25htajniiMqctb
         7jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774581754; x=1775186554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wv77W7mxnTO07L74pb4Vq4itjlYaOHaos4lhPg9M9ug=;
        b=Nq6gt7zUI6ThSwXMgs4QFvYVTp61zgnXvuAR1PVAHvZ/PEnRZBOkf+X+Iv8DbeXFhB
         F3jm1xikF8Cx4EBtM+cIzjdKaUldWlRG/qte9IVfefixvSUv84KfBSRonWNnCzE4aA/f
         ruPcp/IyAf1tNIoxaC+1skM6Xtkc3X3evgeNhPCvWip0jyeLVw24oEQ3RJZEHQPYfe8v
         nIroq5XDmixcBWhNQV554VDAXTfUmDO/mYnvqEEsFMwSU+IxOBFgOLjTsRE05S0Z7xGJ
         HT8GS8aT1T2+fNbRsp1Wvdvorc6B5/g9iMbOjhe8UvFr/a+5yhngXoavm5qI1T6pv47L
         CkzA==
X-Forwarded-Encrypted: i=1; AJvYcCVFBCJimyHkdcCX+3yu+loiy6Efh9wqzHqIHeGMAN5DAnvygGZRizKmCcQ0X+6E5M7jwMa7zqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2+bRaYpW2L5zLh1sioiQoh9oGCNIyGOn/ImzZLBP3jqW/vxdN
	zO0t3T+aAHx8KY9k14ARFVW5QZwrxyvTlJNsY999LzSrSNnM/QGDbelTleuF6kDGYCLQsFDvldC
	/WzeFs1KA6Fisf90K7hUit37AbI4Jexkh4r1r/js/5tV4ThgCT3oozv6LiXTa4bolBjktj/gFEx
	hOX3ncdHsXUWk9F6jPO2DAylZ4IgHd6Axp
X-Gm-Gg: ATEYQzxzvOgDPnloEdjzqAw0GxkGfLFjqSmdaJperS0fobnnPLCl298NLqwOIG4h2NS
	meKjzZgTlDMyRUb6Vwq6AvZf9ZPrtGMKJptALf1rtVhfwQidT4FPTEMzf87QYhUE4EILg4o5Ntx
	o+I2MgBd0Mn5qdecHKnytpZKEt6ZiukJJTY1cbNn2vU/BzI/XVzjM1MfHE0WBLgISyCW9JnNOZP
	2NYr8U=
X-Received: by 2002:a17:90b:4a48:b0:359:ff8a:ee42 with SMTP id 98e67ed59e1d1-35c2ffa83cemr950727a91.3.1774581753691;
        Thu, 26 Mar 2026 20:22:33 -0700 (PDT)
X-Received: by 2002:a17:90b:4a48:b0:359:ff8a:ee42 with SMTP id
 98e67ed59e1d1-35c2ffa83cemr950700a91.3.1774581753140; Thu, 26 Mar 2026
 20:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323041730.986351-1-zhud@hygon.cn>
In-Reply-To: <20260323041730.986351-1-zhud@hygon.cn>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Mar 2026 11:22:21 +0800
X-Gm-Features: AQROBzCFE5yNeudv1jbnEaHKk9QQ5gzetZYF03o_GcVqfFHFVnUqST7F4_jDeEk
Message-ID: <CACGkMEsM2n9hA0WEE3B6+YcLwwh=SvGYFWcKbKTyJvYkh=N8ng@mail.gmail.com>
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
To: Di Zhu <zhud@hygon.cn>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn, 
	yingzhiwei@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272351-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4465A33EC84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:18=E2=80=AFPM Di Zhu <zhud@hygon.cn> wrote:
>
> Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> allows control over offload support, but the offloads that can be
> controlled may have nothing to do with GRO (e.g., if neither GUEST_TSO4
> nor GUEST_TSO6 is supported).
>
> In such a setup, reporting NETIF_F_GRO_HW as available for the device
> is too optimistic and misleading to the user.
>
> Improve the situation by masking off NETIF_F_GRO_HW unless the device
> possesses actual GRO-related offload capabilities. Out of an abundance
> of caution, this does not change the current behaviour for hardware with
> just v6 or just v4 GRO: current interfaces do not allow distinguishing
> between v6/v4 GRO, so we can't expose them to userspace precisely.
>
> Signed-off-by: Di Zhu <zhud@hygon.cn>
> ---
> /* v4 */
>   -Move the hw_features update logic before register_netdevice()
>   -Target the net-next tree
>
> /* v3 */
>   -Update Fixes tag to dbcf24d15388
>   -Refine commit message using Maintainer's "too optimistic"
>     phrasing to clarify the risk of misleading configurations.
>
> /* v2 */
>   -make the modified logic clearer

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


