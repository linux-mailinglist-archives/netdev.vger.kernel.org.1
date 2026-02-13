Return-Path: <netdev+bounces-258640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKjyBQdOj2nnPgEAu9opvQ
	(envelope-from <netdev+bounces-258640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:15:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A3A137DD9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC6D6307CA32
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79C364E8B;
	Fri, 13 Feb 2026 16:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="I0XoICng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5819361DD2
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999256; cv=none; b=cVt8XyGOiWL/YKz20mD7ETHb1oDaSDr9BCJ3VYRY9JVO43lbK6pEvFigLBwbYpIigdHTIpl61cOtPG7XNrxnBG7Qq0a0kpILdKHeIJ603dILVyLIhie39kcPBjvWgjIXLVQCmWnj3HEMfBDBNEEkwfyx0t3HXTjw0O8mwxEh/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999256; c=relaxed/simple;
	bh=k0+aRJ3IUuarB2zMZblbi3T0axeHfpnV60kS0VoDgF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1AmVaXbD5Aj5yYggGo1/SaSKezaqhZpVnvcam9jOSQ544GhfFDpvOeewVgyGGyoVWEMbrlX44sUuZu/b7cGIAYtXBzn2Cz00M9rFTtVc4VfdjHuD9Cr4ic2Zk74xlN1i3zwJNwPCFXwpHUFcyyn8qNfx6fXyRGshq4t9ozKYkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=I0XoICng; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c6a7638f42so158219485a.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770999253; x=1771604053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ohzmGcjlqDye0brlPb+kXwsuRqWVNcPe4L1+AfQUaY=;
        b=I0XoICngKzupTlLR2OPZ7xDnbt+M6NUCk6snFjnAc/Znx7TPkMLNSntK5mJfHMQru6
         E4W/HPsxsKxIaF8nQFLEL8Jlcv05SDnS6i+H8rilrXwEax2hw2RasmkEc2FEPDlsOe22
         wGndE4mk3Ho+0dzvfqHAVP3EP+QaqrsfGFa1q6cf0qhNpRq0YNIjowajPPiNo5jJ2fw7
         +n3F7sWXzeSNFc/B4kmLRmVy8kp8jgZyhBvrpdYB+V9uKul73ovjKYhd/0QYzWqtCmn0
         SdfbBRmVAq5FWSvGdyMJJrII0yuvmd6FN5dn94lihNFqJqdHCG5bTAW2PpgE99GX7iiu
         Amow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999253; x=1771604053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ohzmGcjlqDye0brlPb+kXwsuRqWVNcPe4L1+AfQUaY=;
        b=HQktDz4VWrRis4XFIneS+KlBVzGwyHbXjo/vfqgZOX9cSvNdcezqOyJ5SX46Al+ZAK
         oRF7iA+SBXNDbxELkpeh82//Tq8OQN0uOmG3T65K+exwKr1fipicRhXfEssr2zPaQ/qp
         Gmw+/vNuU33SJwiS60n9t0pl7aNolxvINhpHLudAzr/cNLKVlleZRX41krQzreYPLEif
         7eJAbVYJeNmyJ+aAjtqyynWKh1rhQlNv1wYS6RIzbvn/VgBZDJbxgRcckZ7LdI+GFzm4
         jxekApXdjKf3uZXJijjkELrmFBSexc2NG27J0wk7rK54PmGozvu5GgHq3SOczy+TL760
         6tMg==
X-Forwarded-Encrypted: i=1; AJvYcCWGT0IzH5mG0D+TYIqhNxAWjwk45J94u+XNuyjois0MORQR2TP5AS5Nmikcy0BArwTqHxuVMx4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7s1StTz3XxeNIkyMP0zihPw6vRKLT9YUCbwaB9hHrwrN7YAy
	TJ5VyXcFU/nbm/02TJj+RDPqs8ekaGjl8nZTEncNjRyuUqnmGCRp6LR34uioW4L76jdmcbZVJ1S
	f7XyW
X-Gm-Gg: AZuq6aKXRnmLcYAT2wGEyxuSaMe4ho1uz1XdTqv3/SigSyeVHKgzKoTGKKIMxRGtAjI
	BbMAAPmy7/w55nSe1aUCshIWfJeq/lkbN8K/50pouj//eecpqQIHQEkWmCXX+IPC8m62PqEldsc
	SGlQ7nklI2DEp+PzQdVljzSZVCsQkkxNjKp7NWqLjyYJXiIc7h3I2I5GoNRU9akTNsE5KR5SCLT
	ecgHUC1xjpHHMGeBHllmlZzLvPOdYe8wRS0Ywc1pKlO1RUHMQafcHYkYBK1RqfRiYHXVAXK5lFp
	LjZIGk+ETAsrSghymkJb3kgC/JDd/MxDdg9vVKS6HkG7AK5J5oZmKnMuaHStt+9xAjqqda6D6Ft
	kbZ/CdmGu1WV3S7NZPe7P/cu0MwpJRKmSLzjWDBE7QGtR0zrmyQJygHUoVFeW5CvtVO84QUQN5Q
	T56qu+Zff8tUR72cNS97rvOWnmN1wZNHOp1/7TeWM53VKEAe+bwb24gke0CW8u61nX8jqX811UX
	LRv6QjYfqx/rz4=
X-Received: by 2002:a05:620a:4444:b0:8ca:fe7f:7324 with SMTP id af79cd13be357-8cb4c014375mr1237185a.53.1770999252828;
        Fri, 13 Feb 2026 08:14:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb39da3dc6sm401861185a.51.2026.02.13.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 08:14:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/22] sfc: create cxl region
Date: Fri, 13 Feb 2026 11:14:06 -0500
Message-ID: <20260213161410.2945294-2-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com> <20260201155438.2664640-22-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258640-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	DKIM_TRACE(0.00)[gourry.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gourry.net:mid,gourry.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32A3A137DD9
X-Rspamd-Action: no action

This review was generated by kreview-0811365ff2. =0D
=0D
This is not an automated email, the reviewer though this report=0D
looked valid enough to consider discussion.=0D
=0D
----=0D
sfc code so won't speak to the internals, but ordering question seems=0D
legit.=0D
=0D
~Gregory=0D
----=0D
=0D
On Sat, Feb 01, 2026, Alejandro Lucero wrote:=0D
=0D
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sf=
c/efx_cxl.c=0D
> index 2cfd0a46225f..4d5f3974e51d 100644=0D
> --- a/drivers/net/ethernet/sfc/efx_cxl.c=0D
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c=0D
=0D
[ ... ]=0D
=0D
> @@ -147,11 +155,11 @@ void efx_cxl_exit(struct efx_probe_data *probe_data=
)=0D
>=0D
>  	if (probe_data->cxl->hdm_was_committed) {=0D
>  		iounmap(probe_data->cxl->ctpio_cxl);=0D
> -		cxl_unregister_region(probe_data->cxl->efx_region);=0D
>  	} else {=0D
>  		cxl_dpa_free(probe_data->cxl->cxled);=0D
>  		cxl_put_root_decoder(probe_data->cxl->cxlrd);=0D
>  	}=0D
> +	cxl_unregister_region(probe_data->cxl->efx_region);=0D
=0D
In the non-committed path, cxl_dpa_free() is called while the=0D
endpoint decoder is still attached to the region.  Looking at=0D
cxl_dpa_free() in drivers/cxl/core/hdm.c:=0D
=0D
    if (cxled->cxld.region) {=0D
        dev_dbg(dev, "decoder assigned to: %s\n",=0D
            dev_name(&cxled->cxld.region->dev));=0D
        return -EBUSY;=0D
    }=0D
=0D
Since cxl_unregister_region() has not run yet, cxled->cxld.region=0D
is still set, and cxl_dpa_free() returns -EBUSY without freeing=0D
the DPA.  The return value is not checked.=0D
=0D
Should cxl_unregister_region() be called before cxl_dpa_free()=0D
and cxl_put_root_decoder() in the else branch, matching the=0D
reverse order of allocation in efx_cxl_init()?=0D
=0D
The cover letter notes that v23 expects committed decoders as the=0D
primary flow, and uncommitted decoder support is deferred to=0D
follow-up work, so this else branch may not be reachable in=0D
practice today.  Still worth fixing the ordering now so it=0D
doesn't bite when the uncommitted path is enabled later.=0D
=0D
This issue is not fixed by the remaining commits in the series=0D
(through 10fe989f9e85).=0D

