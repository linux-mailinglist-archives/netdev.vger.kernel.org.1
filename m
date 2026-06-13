Return-Path: <netdev+bounces-299079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x0RsFNPYLWpUlQQAu9opvQ
	(envelope-from <netdev+bounces-299079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:25:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 545C267FEBF
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:25:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=igpbZWWh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299079-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299079-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FC663002B60
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05C395AC2;
	Sat, 13 Jun 2026 22:25:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0301334C3C
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:25:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389518; cv=fail; b=im80CMLuIJrfQ9V7UWBpzrhoie27yHkUKm06zp+YgwW8ceFG1f8Fvg7u9okgRr3gnApeScvz3+ImqPeS7avkqak/SWdXO3DkswGsyLHoTL30HPcMBVMFWMLR5S6RFm7ANthLju1BwrrZLLJkkiHu4LnWgGnTRyrkxmcENWs7PBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389518; c=relaxed/simple;
	bh=1bdEY5yxv5t9XP5TtCJFWuEDTtBiQLjm4/B3JBKM7qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWzWtmh3kfVncJIqoWEJmgGdqE2+M7jNCgOtmMBic55qALXkDv7+RN5HGxKWvL5f1+lI8ArKYODt3ATEm5RE8UfDXT402IozvLX9bb/aJ/vLC9FiGgGKOiwhZa1NnkINAiqAXU7ggIplheNmtrlYeVW5C6/D+adrtVbCnh9uaA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=igpbZWWh; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DLsNti1751264
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GRdIE6LSM1bH8RC9lncAbOJ2JdACIXbSk43KFW5xUf4=; b=igpbZWWhgcAG
	UQRhHeAkQUcQT9YS1C1yizMLyYubisFvGTIHjvXAP5Yq4zFuMdy0J6izagbAVYGE
	Oh4Rla1pSyswX57EwIqs6wjhCDpr7SSai2oeugc/TSvmNQ5+HA4Puhr8hB2sZfKm
	K24vuXIvlgHEIVuujAPmgQN4D9olXWM87UFrSbGJUSfPnONyzsT6/QOd4nUKplB6
	+eaVfmM5zaV0rySMY0pM1OEcco2PwpNZ4z+evfY3ySdK+6zvdWUdR9NvkMhTpJgz
	2PddCQmkEQIS46pCY7lwRWXYNf7regn3XsKqdJFxiGmJlAP+qmzk4l0OhsbMgxA/
	LQsjKjm8TQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2bbjfx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:25:15 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6db540d17so3757245a34.0
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389514; cv=none;
        d=google.com; s=arc-20240605;
        b=aLC99cl9MCs1r5NYkg7eCXrTvup790M30WP47zR73AFO3S5NZVM4Dpfpqf5l+k/ZO7
         jKtAdqXmgJDUEaKbdUfoTSQ4YDwczAHxfG4/Vk8Yqqfz7EfIn3dIgujvo2Ljg/vE1tvg
         70nh86tb9HKnvXDBs6uryQYByUrCcu5YlwXTjVWzD8GhrcYm24zl4cq70pzoaiq2Ey9C
         mvvdlc5M8BzDFsOETzHFhr3N0aTxTQQAe99+stF6Q3zE7POyLoK5fLRnUCjynOgWOzC+
         8D5BSBjAQyhJasNRGbggbE7NFSZPEaR1N1RosYZgcBNPNcbf7x/R18yOltnTpr9KcClM
         QEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        fh=dZoFjI9xwtSwRur4dfWnQC3D2po2ugS5cNBrK357qPU=;
        b=VnDFcHoXY3INuvO8lR167goEytkhvKsxPR4XZET4UBZXm1Cdg2S4VatdDRDvlPhB3H
         aCE+uk++3/LUyUc1HIkmILlZTT4dPn83jBWGqqMWnZ7eFdER/nUto5MfoL0r1YrMnl6N
         e4GjfVIdBHeMA/GdhH3+wPOYaeSmSHev8qH++U+kXC3i8PpjfmHY+0f4iDJN9y7rPG8J
         lufHbul7MXUIjL2lGfXX402ivth1y+UlU5S3vrC/qeooDPHQNi/ObR0RSNMxRyyDnyDf
         ZX5l7vApXG9mR5NNynAU2EVMuYFlsKe41eZHnM5gccIOuX5GMuYOD3/pbX8lZZgwbA5W
         qP9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389514; x=1781994314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/EAQqigRSI18sLOr5BrBLiEKIx0cvrRCkfg6C7SoSw=;
        b=nH9A4JJIr72kLe4HBPm1Z2maFbS6miIvg8uoFCgaRtNhz/fxVNT/MTT3SPjhv/wUe2
         5J40zBAYW/AOvwl0kdXDT6RLxYdajt7SDJlJoWpxHbLFPcA42IsgLj1YxoiIXyEro4VW
         yrw8f/kiVv7SF4WaGbLCUJMvVXAGuVtT25wMcywoUdVXbLxT5xBRjuQfy72EUk2EMrHh
         5F2cctVLfOLPAzNAz/UxPmc7jv+ejKWdVxSfm0QzmiaQhc9nqa+8d1Sxden1NFXZmbY+
         yl70IAfSu/O0fmVcAKe3kd7wLk5XSPh/SEndRYrOYSG19frGlXBEwFzXrtwmh2N/putV
         fV2g==
X-Gm-Message-State: AOJu0Yz2QvFLGv3hDCgxUD+wdNA91uVrMY8rvPZfkkeWX0/h9sLpXn11
	JtbXSisOZq87g0lSGRWWhoo9jcxzidoTsFQrqTZFYrWgBMNfgSEVUfGHkkBqI2+QINP6szcZT7o
	iKKk9d2qLq9LSq5yhde5yiajSvex+HFlnlPTPgaKhLm2FaYExcnD8RJbEBa1EpewXHE8pHXPuWE
	xMJU39KH773WhlHHF4kBUwVgch/A0xpn8=
X-Gm-Gg: Acq92OFsewTUkPVgXBX86fAzxIa6Fp7P3EQ98TeLcrActfBLP7Ln+39VOA0t4Z4LKn8
	qCzQVx33MtSRpSyeHkVrGHoeV1JP01vyHBaH0QivwY7+8ZfRZRpiob0ATDVZTrdNStsbmJNG1hR
	yVUBEetsE6SRhIZL9erX4jCjmsuIidWYAeHtNKMYY6Cjpo4DkFwvTcENLz9qzDgW1krcR7qw/cQ
	4TjjnTt/GbasVtbhDvIRA==
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id 46e09a7af769-7e78e75e354mr3483167a34.14.1781389514239;
        Sat, 13 Jun 2026 15:25:14 -0700 (PDT)
X-Received: by 2002:a05:6830:6187:b0:7d7:fd71:f2e4 with SMTP id
 46e09a7af769-7e78e75e354mr3483152a34.14.1781389513778; Sat, 13 Jun 2026
 15:25:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-5-zhipingz@meta.com>
 <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260612111001.5b7206eb@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:25:02 -0700
X-Gm-Features: AVVi8CexW_WJJGnDTI4HN0FLeTaWayUrCy_spJuvDIJixjLtGyyKLpDTD_UhDYM
Message-ID: <CAH3zFs0Nr6PCEVj0+iyAt6bdOVdQCnmNOCVuJ-5v7xAtKFuXMg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=IZC3n2qa c=1 sm=1 tr=0 ts=6a2dd8cb cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8
 a=e6IX7qM6bnzC-tgAjTwA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: qRTZoWVxQ4fsaYDAAMduNUBlmGhotajU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX1xKrrKbbkMne
 XSLzIX90wZQExSOJZdxxwjMMKTp19P6TKdQV08aGngDOSJnObLcVPUZ05LpvtK3DyQqWjEMXcG3
 cySQYuC6DqKwN6RbCstZwuUIEb8KtGs=
X-Proofpoint-ORIG-GUID: qRTZoWVxQ4fsaYDAAMduNUBlmGhotajU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfXxlfjmzrbOTqU
 OUz9Vr6orrWU74iHpzKa79vyxinFG1+7HtrqQPrawH6oCHxE35meXj6pU0KpbGqy4znf9yNT6iD
 lwv3t6qziY/CuhVbwDFIICwU8VWvtMktufFwiKQUSy7QMdR7IO44H5+aVkorEd8a7T0LtK4co51
 zgDdzoRfwJbK6mNdOpeKFMdh5Hdt4rn71UBhx7yMzYOa3v8dyn75pOvIrJ4bsrVT9J0GsRkNvo1
 /ZOp2kpK2gsunrKYErxNfFmjxWhFTPkvCtwamWrdvaxRqFQ29tok33Umbs16IAEWEKEU6jdGdyO
 +GIl3jbw18wC5F23jyNb6dBOCbonaKRxjx6bagVOVAprfK/thDE0uHSKFOQvmoH7+UvmxBAebST
 RU3rxT7MOZWct7fx1aElb0jCKKS1ool+JTbRq7RBzrE98Htun5eeqpfasuesUkAKYH1bktA4Qr/
 UlozzyzeHADmnxFPeTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299079-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,meta.com:dkim,meta.com:email,meta.com:from_mime,shazbot.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 545C267FEBF

On Fri, Jun 12, 2026 at 10:10=E2=80=AFAM Alex Williamson <alex@shazbot.org>=
 wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:19 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> > VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> > for a VFIO-owned device.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags, and get_tph() returns
> > the value matching the importer's requested namespace or -EOPNOTSUPP.
> >
> > Publish and read the TPH descriptor under dmabuf->resv, matching the
> > locking used for other importer-visible dma-buf state. The SET ioctl
> > takes dma_resv_lock_interruptible(), while the callback runs under
> > DMA-buf's asserted resv lock.
> >
> > Reject requests the device cannot consume as a completer:
> > pcie_tph_completer_type() must report at least
> > PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> > PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> > check so userspace gets the narrowest errno.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |  3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
> >  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
> >  include/uapi/linux/vfio.h          | 37 ++++++++++++
> >  4 files changed, 145 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_p=
ci_core.c
> > index 050e7542952e..4fa36f2f7555 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_devic=
e *device, u32 flags,
> >               return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> >       case VFIO_DEVICE_FEATURE_DMA_BUF:
> >               return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > +     case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +             return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +                                                      argsz);
> >       default:
> >               return -ENOTTY;
> >       }
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 1a177ce7de54..0a0705c8dbea 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -3,6 +3,7 @@
> >   */
> >  #include <linux/dma-buf-mapping.h>
> >  #include <linux/pci-p2pdma.h>
> > +#include <linux/pci-tph.h>
> >  #include <linux/dma-resv.h>
> >
> >  #include "vfio_pci_priv.h"
> > @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> > -     u8 revoked : 1;
> > +     u8 tph_st_valid:1;
> > +     u8 tph_st_ext_valid:1;
> > +     u8 tph_ph:2;
> > +     u8 tph_st;
> > +     u16 tph_st_ext;
> > +     u8 revoked:1;
>
> If these bitfields are now all protected under dma_resv_lock they
> should be grouped together with a comment to that effect, no need for
> revoked to get kicked out to its own storage unit.  In [1] I'm
> proposing runtime modified flags each get their own storage unit, but
> for more isolated cases, so long as we keep track and enforce serialized
> updates, I'm ok with runtime bitfields.  Thanks,
>
> Alex
>
> [1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@n=
vidia.com/

Sure, will group them under one comment.

Thanks,
Zhiping

