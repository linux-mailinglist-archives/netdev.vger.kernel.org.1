Return-Path: <netdev+bounces-251885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDvtKYzXcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C057A7F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65B8D6CA774
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B7F410D39;
	Wed, 21 Jan 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJvMSRG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F33E8C56
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769002184; cv=pass; b=Rt3fHMJ9Fs0SqPuICNALq6OSwCt9T6PCum2G+rGiS1HWZul7HNufj+Y3oN16wZKRfqHMP/RpgDZk0y5Q3FQxUUrDkM7DPwHqq3Ti0PZXZ8mZnpZ1IJFv0qFRqjfpNSSxDD0ac13T1llbCRhVnCNPBubnVlgYFdrZr5UBmBowTAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769002184; c=relaxed/simple;
	bh=ENLA4MLAzTdDZw1TDD2l7KtXPxurA3A9DfzXwNut6mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krKxJZ/dE5pVv509gImYMNiHvAEnLqGHrKpQ+MHUcP8a5RUnhVhm2dNGjBIejLD5B5VDBQ/BrTmQw/U5SPBu6M60tNJF5FiIfMrmcnPuhNuVSx874tHIE7uwm7gRl60iFflqQzqQ1SXWpA8LMRt5RahMnaYwqDNj5DBnXfmW5Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJvMSRG7; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502a2370e4fso41390611cf.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 05:29:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769002176; cv=none;
        d=google.com; s=arc-20240605;
        b=EcV7NYFfqfhIn/+KGzAyUxkEQ30brZkUmjKuAl05aXCbwv+6ztKWiC9CvYQlg2c1S+
         VJcVR+jJ3UmWjey5d8alZI4BaSXRE78pufqEP+hecQB8a7kDwcweh7eoGgWuRWfhFE+r
         gdoJt7DJ/matHKEYHR5RJRZmc9bmBk63hQJCzWGl+69xGG3AsvLzuWDYagVrtitwljtw
         JRcim7Zymvkk3wmxg/nrv0BQeDuPeHOFUMLlynIpcK+kTKVkmkE8RYsWVYCL9s2nTcrx
         YOeSqGSBCqNrkINbVOCViOTzS2DZLxwMBKMRUOqAVKviV8izh03JVVPHXOqUT9bdlLwt
         WGYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENLA4MLAzTdDZw1TDD2l7KtXPxurA3A9DfzXwNut6mU=;
        fh=g+1vq1meh5m4mr/jkC1BzoFTyNNXGxzlJwxUFzo+JgM=;
        b=Vkn6eHT0vUDzLigHqohMJ0txUn2t1OVu9V/YLy+zQLKJDkE2olOWTiBgKqx2J6XYav
         dLuX0RpnUJ6bnDnv11b4y0IwNep5TugKjO0JQQIbmkVCoqwwbkh13+dy62reQkN1FmY1
         THkN61Yi99LICrx94mP/TS3qa3EH2EfVSdEQAnPa66dR19ESlNAF1TkH0cqZlU5veV90
         PH61tuigASHuD5o4GuSh0xx4PVVdReMUNi0I+A1knKnIfHF97tFjS11b83doGcB3AuOX
         Z/WGCEnH+4mJiMN7Zs8S55nd8Fba47SF69c4cml8u+iiweKgaobNXqPavSDXvrzCgNlO
         VaFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769002176; x=1769606976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENLA4MLAzTdDZw1TDD2l7KtXPxurA3A9DfzXwNut6mU=;
        b=jJvMSRG7I4vGIZaIXXSOcC4QLbhuSMbViUR8q7xY4sy7T16fE7lEtCjGNCyCIQJA+E
         6+5FcnFL1BXxZeTdMCs1VyaICtykb40PwzIty+9Xq43eHb1JwaLNHXMbBOrogztKusM3
         SYtKAVyx1zxjvpIYadqe8mxqxFFQoLpLY4qtgfKp1DJ0t1KIOC01v17DOkgXFc6LZ4Pg
         5f/ifSMCipCFy6g/iGW0pPO11DkCRroM9YmnT344gkrG7E4S7cgUTD1J3/HECiqC5wBV
         r8UP9PZZW2UzKH7ZBEuM6GGyk2z827pz4JKZiRXiFVWBI+lARnkokBETdOBAaCffGIlV
         sbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002176; x=1769606976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENLA4MLAzTdDZw1TDD2l7KtXPxurA3A9DfzXwNut6mU=;
        b=TbAH0ZrDrqLjFsb7KTM5eQz4L+B3O41/gTf5uufld4bR0klyLg432PuXQ352DzOupb
         jvjL5Q6TV3XQG4TzALgxLop40jSEEUAZfnjaqda/AkAJ/0pfZTsJDeXa4W6y1Jt2KY31
         yceTh2CdKYRXuFUvxEilI0fQSs2avg9Dcgrh7eD9W2RzdvN9XsYqulbqEdlWuC4GKJ0B
         caIpbyx47/Xc7xTKLjVe1DxeQ9644bmcZXojRDVbchmTRdlDwRgbCVTyFvrmWVuJ9vcQ
         6wiO/dQy92L+eNPCJCkRULmI8qsxKN982JGduUxT4AUrT0VIyO0Y4F+RPD+jG+pcubn4
         DT5A==
X-Gm-Message-State: AOJu0YwVAhlhrTu1tNP3/3KP9lKkQqMkwMH2BjSldwsI+Fl5sspoi8gu
	SIebdhWxVMvL5QnHscrgoe02KntzhaB+JFEMc1J90Dw3v1xQHBKxlz8qu+hK/nWc8JQRvvKoUsi
	ZBQw7J4smJFZlayryMYOrkcLr8sxTtnSOU4nnWgJA8GxIFIrG9QvSR0WE
X-Gm-Gg: AZuq6aI+OxOkshn4WnCNQuzNnRncI9z1CCuCTf59FtIgGqOv2g7WBNhzUzecscmLCDf
	caUrhOpvC8UhPv70GxI6MDDkt6ZQtokjcxouzjVMNqzZS/vYju1EH5aFsQlOJ5fFq1Bm5hDAkjJ
	xslyElnt3bcdZhe0MnB8vKU8RfsyifDaUbkITTUOFb5kZuBbQEYSwIuVWURdUC4l4BiuKmGiCj9
	9T1CCvAWUF6CXBzJHIELq11Awgu3ajZ9JjTu5vzDzxUCb5iSiNoeXf699SmW4LO3y4TRGDrSPS7
	Gg0mVg==
X-Received: by 2002:ac8:7f54:0:b0:4e2:ea31:1a with SMTP id d75a77b69052e-502a179b851mr263703021cf.68.1769002175606;
 Wed, 21 Jan 2026 05:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121072932.2360971-1-mmyangfl@gmail.com>
In-Reply-To: <20260121072932.2360971-1-mmyangfl@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 14:29:23 +0100
X-Gm-Features: AZwV_QioFOF2oyR3s9SWW6t73XCQEmhS-JRRFnzpIrMcEWxiPAU3lvFrRlrISBw
Message-ID: <CANn89iK6_eoc56uTHiAJbFTyddmzLu3pp364j9djdO6H51utiw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: openvswitch: fix data race in ovs_vport_get_upcall_stats
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, wangchuanlei <wangchuanlei@inspur.com>, dev@openvswitch.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251885-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 5A1C057A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 8:32=E2=80=AFAM David Yang <mmyangfl@gmail.com> wro=
te:
>
> In ovs_vport_get_upcall_stats(), some statistics protected by
> u64_stats_sync, are read and accumulated in ignorance of possible
> u64_stats_fetch_retry() events. These statistics are already accumulated
> by u64_stats_inc(). Fix this by reading them into temporary variables
> first.
>
> Fixes: 1933ea365aa7 ("net: openvswitch: Add support to count upcall packe=
ts")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

