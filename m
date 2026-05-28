Return-Path: <netdev+bounces-292558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGP1K/zVF2qOSAgAu9opvQ
	(envelope-from <netdev+bounces-292558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55E5ECF6C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 07:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03AB8313004B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910A731F9BA;
	Thu, 28 May 2026 05:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bg3I3NDv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B434389E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 05:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946525; cv=fail; b=fLLHUIBari3rUPqQE5kw9H4ATfsLgbBibpfA1lt5DmsnrbUUwW4V0vq+CpnL4Hb7JYplnRenz+sWbg7uVC49y0pIqbd9vMLajIiur/iRWA63H6lvHGSTF3bcQ6mJDEHCebO1ilYLcRgPBT+nm8qCABl8rBfsWQ9y5Y5dFd3hi8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946525; c=relaxed/simple;
	bh=EnANVMnjWO2e/TF4qUwEkpjdrKKtkAxRlIBS/3wsNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZtoe0y2ogzctvcH49AmiflOxi89aMueZwGINl7y/7CRlVkyU3flZaWZY9XRh/9YFU9FxHQrMf1GGR+xIs88NPWpu8wMcU4szeWF5anw9JCevREtIHWVkaWAYXBqKSbkXwK3Oe8NzcSXH5sznWP9YagTAIVhOZYtR2CLN1Ahg3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bg3I3NDv; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjQZQ382446
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4PCAVqJEOIY16WjmmTqer3R+L0JDJr0Ts1ek/LWm3fc=; b=bg3I3NDvy6FE
	iPpy9G16MrgkS7tjdaK4pTBSzqZEYYkSr5lSf8zBn87x/6ztIBfNAOzJnXbkITnP
	VFaM/GIefnYWYt6TOhjePYUTwpWHC8tb9G94iars8MRPC0B3+3Bv1ehGIH2uF3r9
	X+cCM1mir88Ht7erbVTrSkMQLajLsqaX4Ka+CzlrYNI/+3xJEgpfsUb0R2FOT8oP
	C+oZphQuk8kWYB+GKsZEiR3QK1YcNTIkHoPt45gLIQZGmdCOi/qzknAC5w6RIfgQ
	ucUNMGl3JC8eLuPUn4MPOudkHIaVMon2NrKpJ0qR7sanUhqV/uTqc+2Jx6QeO705
	BV/ccfW4zw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6tbv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcda4880efso15427515a34.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:35:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779946521; cv=none;
        d=google.com; s=arc-20240605;
        b=apw5U/sSjhwco2/Xx68sMZLimnK0F/7vtyECGMo8XKvcHgkgfVTbOpPKof89LvP/n2
         dyTfP6E5jMKjKbCeT+jbKAfUwHoJbiqNFTGPNUUQQOaeHdLu3JTU2IsZpGZNfbbKA0fv
         QZ7ijXOcEdo+0UVNuyRNS3kzTfmD8XqFEhutCpSQ5x+IkgUAJ4h7RHIiCEFQIItSrm/k
         K/DdE83yRssDglbJsjmzMh3+odV2g6y2TI3S08mk17UIYdJ9/mQt9jxwYIgTQlknAxLm
         ReNB87f+1DmEHqVA/QEC4SO7jPxxUcxVRfG5opMU6aq90gLelzovFKtCO9ELpZloIQnV
         GFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        fh=Ch9x3gsu4OQ4+yInSPL1iTytlqXSGckPO3hsPj5p/Ng=;
        b=kRIWmEFwp50G6J2d/rEOHkQD+fq6CQwx4mnKqlXBOrNEJekcVe7CWQkns3/Epo5+3x
         4n42STiWHP6VMEwf32XKu7DFuKQApXOqfvrB1k33xq+mKjgrLaERG6VFev/DcqEdsykQ
         9MJMOizQdt8bGm6JriWQGxu8ezGdoDfvGDYrbc54IoBlCqpFgARQeS4DIisC7UIZpw3J
         P5+KCoEJhomfC6bnDn+4h9kSxd9vhanYjZyrZhYGPA0AMU6yerurZM5We0RpUquSJRpv
         PpIAdux5l1aRWPAgGgsgi20casuz7W1Pu22FSAL5mu4h5Xg4r5GEXKjCfICeBGF1DoZL
         05ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946521; x=1780551321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ6Y774MTUFrTACHvD9ZqjUGy6Y+0XLmHrPjxlbHslg=;
        b=Hep9t6GvBIh6csSOiekvHPiz4Z0OH2m7LpV/teLdQdr9qas+qTh9k/5RGLLEOB+wcw
         TBZPynr8R3ZOiB4J4g3qn//pBRGDHKdPg5W/an1731n82Dr/nYow6tXHIOGgHoyVltPU
         mKXTuG2XsCmZwwO1zO8dDoYRO6HGYrcY70irSAc/znGqYYcSfC5WXfbYhnJYRSM7Fa28
         w0lwIkU29R5QFtHD96u+H7cDVbWQDqZdq1VJJmS6NKNpCVGR4bcRGHctNaUuy5v00crp
         +jMYFszHHmqny+idIkFtxghmR07ZuXV+3+vPgutC389M+1Yg3yiOiPwc5qC1/OIlpOxT
         YMEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zqcdZCibxyN1yq1Vr1qZFqra3dwt5m25e62e27ShXS+Qq89Ts8w3P90joKNhfy4ZsD4i2BHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaznorFgbHcRFssx7sAUfHK5TE9txkiqeTXAJ1FHXBu2dFsul
	n+CEQ7h2+9QJ8evdi8yctkU4M01f1KHZE2udpPo4hONd4yP/IoBaraFrLEB25Mo3kpPwbOolTQh
	NC1zwSglvJzj/+q+hENErRa+aeMaOtadbecD21VlFqNXHq6p+JfeR+V8ktod2EDKe/l+9LEjiRu
	r8dNr8pzb6fWuFUFp57S6OyyBTGu7IgzA=
X-Gm-Gg: Acq92OGhU4mCf79yV+V47WT6XRB/PTwPwnIUUvKDixmlwylj5DgXOh1xy9zLnsFxXsi
	Winsxj8plAPo0ZbXoVG2gUjGEU6jlnkKRHmIGe9v7G0dVAhvc1MaQrcsB1fgIkfPN9wMTEh65nf
	P36S35Wth8Cdt99lEIGl4b1Z0+XlJdqVKJcEzNg4mm6FuFMyxhkWJ3+BSRd9253JvZ9fkB49HQP
	+kuby4/TuTMvTvh+Rk+gIOWCsyZagBQGF/yPffI+uSKjoY7pPE=
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id 46e09a7af769-7e5feeada60mr15174375a34.6.1779946521032;
        Wed, 27 May 2026 22:35:21 -0700 (PDT)
X-Received: by 2002:a05:6830:6d47:b0:7db:b68f:b819 with SMTP id
 46e09a7af769-7e5feeada60mr15174366a34.6.1779946520637; Wed, 27 May 2026
 22:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <20260526144401.1485788-2-zhipingz@meta.com>
 <20260527145332.30412ea4@shazbot.org>
In-Reply-To: <20260527145332.30412ea4@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 22:35:09 -0700
X-Gm-Features: AVHnY4KV2jkBImuet_2z0_HzyoNlAKuwWC1jyQGu9hjYNIH-m9ItRdizP-UfkeA
Message-ID: <CAH3zFs3Yv2G0rQNE7x8DjBWPE+3sFC_3X6ZtF4x-mPp==h0BQA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] PCI/TPH: expose the enabled TPH requester type
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: pVF2H-eJqXFnWkB6zPRT35MfSVfeFerM
X-Authority-Analysis: v=2.4 cv=Fvc1OWrq c=1 sm=1 tr=0 ts=6a17d419 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Yn1Yo9TDUEbBsc1NC8sA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA1MyBTYWx0ZWRfX9U1Lshyc3ga9
 0WguQXOmgipb5X2I1I5LfnGb5F09nqqbMsV5sAGqbiZ5U9eCyQWtjF6LBXX0Nx4YULj/Dspufy1
 ICAg0WEnspn1tbbvVBnOW34wlzkg6wgvJGCPir8enYZSTv9wVUYSoQITTuk0I6NvAnwSu9mWePk
 5Wek4xn4/GRdwH6IcBM9SFYb7NmCJReeQvVVTSPmhQFwW6B98pxtPdWTGia3kdXNf8p5btTMFVD
 RT9s2SWuA1SsgqO45B6Vu2siUP+kznIlJRJL3O0qJoUA9i3rU96PC2DULnzKLN1bPslIKVVk+uX
 ICRa+AmzZ08TjRSEdm8aiWkZkzf+525bRjlo02n14YeFFi+3WhW1Q0CzBzSGjF5kZoRb2mLbrCy
 7BHnkFhitmSp2gWw2GV5nnt8d91pgqixAzrriV6VniMESdQjY8i6+9QrMTOslkbXEfs04RHTCWK
 cFwD+poMSaAVV8n2wYA==
X-Proofpoint-GUID: pVF2H-eJqXFnWkB6zPRT35MfSVfeFerM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:email,meta.com:dkim,shazbot.org:email]
X-Rspamd-Queue-Id: 1C55E5ECF6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:53=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Tue, 26 May 2026 07:43:53 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > This keeps pci_dev::tph_req_type inside the PCI/TPH code and provides a
> > !CONFIG_PCIE_TPH stub for callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/pci/tph.c       | 12 ++++++++++++
> >  include/linux/pci-tph.h |  2 ++
> >  2 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> > index 91145e8d9d95..6c4492075ae9 100644
> > --- a/drivers/pci/tph.c
> > +++ b/drivers/pci/tph.c
> > @@ -174,6 +174,18 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> >  }
> >  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
> >
> > +/**
> > + * pcie_tph_enabled_req_type - Return the device's enabled TPH request=
er type
> > + * @pdev: PCI device to query
> > + *
> > + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EX=
T_TPH.
> > + */
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> > +{
> > +     return pdev->tph_req_type;
> > +}
> > +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> > +
> >  /*
> >   * Return the size of ST table. If ST table is not in TPH Requester Ex=
tended
> >   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> > diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> > index be68cd17f2f8..fe572737b409 100644
> > --- a/include/linux/pci-tph.h
> > +++ b/include/linux/pci-tph.h
> > @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
> >  int pcie_enable_tph(struct pci_dev *pdev, int mode);
> >  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
> >  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> > +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> >  #else
> >  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
> >                                       unsigned int index, u16 tag)
> > @@ -41,6 +42,7 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev =
*dev,
> >  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
> >  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
> >  { return -EINVAL; }
> > +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev) { ret=
urn 0; }
>
> nit, s/0/PCI_TPH_REQ_DISABLE/ for consistency.  Thanks,
>
> Alex
>
ack, will do.

Thanks,
Zhiping

