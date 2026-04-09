Return-Path: <netdev+bounces-276868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JFaAttX12kFMggAu9opvQ
	(envelope-from <netdev+bounces-276868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:40:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE063C7242
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 678A6300BC8C
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D062FFF81;
	Thu,  9 Apr 2026 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNamPitt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB01E2F6596
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720262; cv=pass; b=nRj8sV46blk/T9marOKU4yakLEDwkCavnIsyrXx4HqpkGUvH9WZnwQ+hR9G0x2CHmJC7PrANsgC6u3qrIEJiaQw/3uDlTRGau4+qcH7xVnqK3Nqt8n7BLZAlEBeWhZLe2a17ihD+WVjbLAIvYT7q009q0w5+SZPdrCP8Rj3a/iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720262; c=relaxed/simple;
	bh=P5kE5PxQ4c70rwOzGc/tYdY0towP0QgFM2GF+sDzvu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EO7es/Vu2Grt882tIfLj9bumhTnjrHAQEL/EuCby/ovLZYXrHSxqHphYESnd6YVgrtTEArerhGTDBbWJ4ufRa3PIyMGEeicjbYBE7K8zwFdN4WGE50730JydvY7YZGRIK/fZnxqQ+BpoMzu5iuWJ5MztoecafcHaJty/EPwfFJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNamPitt; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d880e6fbbso5038191cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 00:37:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775720260; cv=none;
        d=google.com; s=arc-20240605;
        b=M5MF8pd8R+m8eJXvk9TadKDpkU5lxJ6AxAVkW3mM8bsmnf/3+eUnadF8yJLaWtQnyD
         uvSMQfqyoaer5ns2c5VLWVbOb4JyEdklFwsPwCBsRb/KiZvPnjo1LxEIu+C0+8wEZRwO
         MVRpOg8Mamsl9OO5iP3X1rgn6HzFf5roOO0tcnrUYxv0HkEmAWhp186P9pXyIH4Frwl2
         oh+eFVUessfGvIYK5Cv2XPJWWAd9HjJqxerfhGDGAY1DHbQ+k3snYUVdhCM6RwcneETn
         lHDM0/u6NqhntI+TljT7ppiRVsbRFBsX0BAxFlsV9/6xWJz0W8Wfkj8GIrdOR2iRPSEp
         XLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P5kE5PxQ4c70rwOzGc/tYdY0towP0QgFM2GF+sDzvu0=;
        fh=Hu20O8JJR57SGHtxYv9B3NgSiV5rHKRzGYPLSd7KKj0=;
        b=SJjz6OJOZIgUOZCPJzoJTtyuF6aN0gL1q6/t/EWZ8mvA7tMDK6pmjxWqHH9vbr56RR
         +vNCl3NsKe9ZeWJZO9fkIOyDm8qt+lIL7CBk05PGzya/Q0xQxJwTT4f/5pGMI/KL9wrs
         ADsUBRJDJ0zXt7Cpx6DVBHlYPkoU9C2Y/8l0gwNMcpo88ZjyKCimvAyNIAfKPRiuRc28
         HZHw+QPzlBfMFQrp5u4fwNWD5v1bF9sz1KCsgg4tT4C5KBWn9V0GDhXKDhyzbvoI6emT
         5pD7hTUAC9+MM47Bv4ue/LsovELw+UV3HPKPdrVA1IjtfmEEXK4Hp23M8mVviuJn9Qaq
         zr7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775720260; x=1776325060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5kE5PxQ4c70rwOzGc/tYdY0towP0QgFM2GF+sDzvu0=;
        b=CNamPitt582jQiispQUSPTxUoqXUAuE6Fov8PkxMOlfAQGS/MSZ5JU3R8LtDhta6Wb
         N6wBrfFqvOyvPcvJQm5FtPDP/cgmjHj0fQaMm+fsUteeEL4lSGSwPstOaF9gQe7aqka9
         +tZzvULwbJRlsBK/a/lWT9rLz0Rfj+PfBCQYx515UEY5cNG9Cm5vRK25sRRvISgy0D9Z
         hTnOJIbtB20RK63Q6kNNlo9dORcOXczbEGE2TcKL2P3Dp4l6jV0VjrXYfWqkT32PGejY
         Gjffs9aW37A/JQxCVhx/eIzRcP/o2lYMH1BwB9qosULgPfabHM/D8U7KqZbrpU/IkagM
         1edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720260; x=1776325060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P5kE5PxQ4c70rwOzGc/tYdY0towP0QgFM2GF+sDzvu0=;
        b=WL0C82rCN87BqKzAuMtK5QqmrHKMKiTKqWF+O8qrBnmN/CRnKBSwYzDprR43MzKSMS
         oaxRAG4Px2wQB8BvWWlubJCFdss0YLKoqyr9pqzuF6NRW/J4JZVR9CEWlk7iGLDXPHGj
         V/CTMD+Zf3xYMd+8VIfXC1vNugjTaIGQEc6QGAIY8NHXsWZo0GjYODOGe0ms79zmQPTH
         k/XPhA6BAJH/BIl4CiU2oly8fb52yP8inKBV6QBuBnDXO3/2IefHxtBcxwbZCBd9Eu42
         ampL/Q3mP0R6lCu2KAOdt0Btu2x19+3q5tEc2BRfzY/j5jRogG1bz+poQb8INmBshkCO
         /SLA==
X-Gm-Message-State: AOJu0YwqfshQH7QY/ZKdhgx8LwM+G9hgE+c6dXX0rQoNFG8sO/6mnO4s
	JQXREOqLltOEW0uQQrQ9QpSrkjoWNBobz2TCPd1FGqEhRBZRT+vmnT2tT8U9NrgymVoM6INYdbh
	vWHgpzpBdcdsblgi6s5RPr2BSmlAcPCy1OhflDXFZ
X-Gm-Gg: AeBDiet1T8JBu7MVpP4LZfGlJD23LJi8qmv7/pDNqE9+4H7hn0Sz5mmwp3aPkUSJGjF
	njHpsFEb7wEI6IrCUKAawSDrp7MfKJ20gWg9XpJu91d3L300clH2oin0zO7uI6iDUAQxnN2dNmb
	ZtOq8/fx6NeWZ3o3T4EpCsXBh2LOdHcuTOUw56wUjLcGlUWPxwRgyc3WrbJdXGyH4tsPKElhVtC
	9E1r7rcQ+F9MQJfe002JtL4dvWOk0r2na13MGEVkiulasiGIu2RQOFoz0PZDNAsEHj7rDZ/i0fJ
	E56TcZg=
X-Received: by 2002:a05:622a:1494:b0:50d:3efd:bd93 with SMTP id
 d75a77b69052e-50dc1a19bdfmr32962161cf.11.1775720260108; Thu, 09 Apr 2026
 00:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408100044.4530-1-fmancera@suse.de>
In-Reply-To: <20260408100044.4530-1-fmancera@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Apr 2026 00:37:28 -0700
X-Gm-Features: AQROBzAv8HMMj4xFBXAnkQ3mvA6XxpyYG00DMzft7prExdsaTbsY-tCZhRA6cis
Message-ID: <CANn89i+k8XDOYuY_8=CQJ-xSFQy9-5W4cf379NWw=e8tmu__SA@mail.gmail.com>
Subject: Re: [PATCH net v2] net_sched: fix skb memory leak in deferred qdisc drops
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, Damilola Bello <damilola@aterlo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276868-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,aterlo.com:email]
X-Rspamd-Queue-Id: 5EE063C7242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 3:01=E2=80=AFAM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
> When the network stack cleans up the deferred list via qdisc_run_end(),
> it operates on the root qdisc. If the root qdisc do not implement the
> TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
> gets stranded on the child's local to_free list.
>
> Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
> fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
> the flag is present, the packet is appended directly to the root's
> to_free list. Otherwise, drop it directly as it was done before the
> optimization was implemented.
>
> Fixes: a6efc273ab82 ("net_sched: use qdisc_dequeue_drop() in cake, codel,=
 fq_codel")
> Reported-by: Damilola Bello <damilola@aterlo.com>
> Closes: https://lore.kernel.org/netdev/CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018=
Q5uozOo5vVo6b9tjw@mail.gmail.com/
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

