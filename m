Return-Path: <netdev+bounces-114434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C8794295F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D04C281202
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F211A7F88;
	Wed, 31 Jul 2024 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+BqwIiN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EFF1A8BF0
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415354; cv=none; b=ci7Z6TTp5YWB+NtRLZ0/rBfM9zk/ej22XIp5TARibY8mQFUpYjhxk4TvsxJX6JK9YQBVaHAGdLfcPYDZDTwPyl4VPxbLibkEPEn3/tQH3eeyqkC79WoL3G5aVQEXGwWooolcqIX/VHs8jLZ02u49YHVqoOKCSBYSjhsRC7BDWUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415354; c=relaxed/simple;
	bh=em9pBBWToDhQhov//8lweTj1xlQTxs34beKtemVo5RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4C4d3VatbUatbnQ3eI/c6e3F4ZVM20lE+wHX+OMf2eZodAfbYAIAXhTRr67is8k4gFecqZE9vAmQtK/NneoUDZjGQyFeZS9SAziVtNDNMf9kYb34sNcf/sL3uC/hFnS5QioI6X9Ad615hi2PeFmgKncHChZZZp/dOjFc1ODmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+BqwIiN; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49288fafca9so1472555137.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722415351; x=1723020151; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05GQY66LxckpHgdLZ7mLUxuL5+CtgCtqD+9gYym8l6g=;
        b=E+BqwIiNWL1uoBAxWvv6+UyTn8hN7uD5DKYN/IAE9zlVoK9SqYfXPE4qatDC0m8wSq
         F1Eu0PC280tIg0KzlGmQyDJx87l09Rie2imM2Xs2XsrYyRIlEywVjerdcpP9LgVctXpn
         TA+JtsBPa7kMLYl9W6/ApHY72ANc/OWCDQffU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722415351; x=1723020151;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05GQY66LxckpHgdLZ7mLUxuL5+CtgCtqD+9gYym8l6g=;
        b=tCby7ypSIWEj7EUQA5hPR1qcEJGsKL5E6qJWXst4G0leONFIZvavzNggA0yi4eGYk9
         LT09C0JpkfcMkOhCM5lzjTrvxhYTOvC94eQYonZw9bgex+5NipgG4/4IQcfOrIBhPkmA
         zAj/ustB2R0Ne2ik7EZHM8gLN3SmU1fQUgoQQyc84lif5q9Yfdof2QVwO6MeCkTve8XP
         yfnsvRFldLU3IIMGIOgvTHdfwOyxgpjzp9J0Tloj3py0z2nIX5avXmCdKPBLv4/Lv3eg
         h5qC1eXScnWvZsBASLrRMMmOI4TaUrIrzKrPSy1YedaEw6Q7GeeNbyVxaxZ38vHRLYhI
         qAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8NVDY3tQkC6bIENo+FA81KQ0xnnYR0aP90VF2IEsM5bpCZ9OPfcn32yKTd5WQX3Xzgbazjq332tQBv5XLQ1z6F9c+Hu9v
X-Gm-Message-State: AOJu0YzaRFyKqsMa8EuuWrXmendnQKEbiopHlwjiDp/cnYC6Fpbc65Uf
	Ql7wcOA3hQAZPHZk6abMywvPUZvpoD23rUHuoKbPYr41Te+z6WNduI9EZszv0VzQcGEcJbbrwHP
	mFTg3V+vppJDoxLwnJjjHhg0y3BTO7z8OzA7X
X-Google-Smtp-Source: AGHT+IEPDlpY9Q7Tz1YYsc6qgCPt3RuGMiBROTbQmM2TBzYPowIyfVTQEeOCgrPEqW7EA6xrsSVwHbGqubIWcRvvL5o=
X-Received: by 2002:a05:6102:f90:b0:494:3a8d:c793 with SMTP id
 ada2fe7eead31-4943a8dc929mr4849344137.28.1722415351166; Wed, 31 Jul 2024
 01:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0e54954b-0880-4ebc-8ef0-13b3ac0a6838@huawei.com>
 <8743264a-9700-4227-a556-5f931c720211@huawei.com> <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
In-Reply-To: <e980d20f-ea8a-43e3-8d3f-179a269b5956@kernel.org>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Wed, 31 Jul 2024 14:12:19 +0530
Message-ID: <CAOBf=musxZcjYNHjdD+MGp0y6epnNO5ryC6JgeAJbP6YQ+sVUA@mail.gmail.com>
Subject: Re: [BUG REPORT]net: page_pool: kernel crash at iommu_get_dma_domain+0xc/0x20
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yonglong Liu <liuyonglong@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.duyck@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	linyunsheng <linyunsheng@huawei.com>, "shenjian (K)" <shenjian15@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002f0a6f061e871340"

--0000000000002f0a6f061e871340
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 10:51=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 30/07/2024 15.08, Yonglong Liu wrote:
> > I found a bug when running hns3 driver with page pool enabled, the log
> > as below:
> >
> > [ 4406.956606] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000000000000a8
>
> struct iommu_domain *iommu_get_dma_domain(struct device *dev)
> {
>         return dev->iommu_group->default_domain;
> }
>
> $ pahole -C iommu_group --hex | grep default_domain
>         struct iommu_domain *      default_domain;   /*  0xa8   0x8 */
>
> Looks like iommu_group is a NULL pointer (that when deref member
> 'default_domain' cause this fault).
>
>
> > [ 4406.965379] Mem abort info:
> > [ 4406.968160]   ESR =3D 0x0000000096000004
> > [ 4406.971906]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [ 4406.977218]   SET =3D 0, FnV =3D 0
> > [ 4406.980258]   EA =3D 0, S1PTW =3D 0
> > [ 4406.983404]   FSC =3D 0x04: level 0 translation fault
> > [ 4406.988273] Data abort info:
> > [ 4406.991154]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > [ 4406.996632]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [ 4407.001681]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [ 4407.006985] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000202828326=
000
> > [ 4407.013430] [00000000000000a8] pgd=3D0000000000000000,
> > p4d=3D0000000000000000
> > [ 4407.020212] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > [ 4407.026454] Modules linked in: hclgevf xt_CHECKSUM ipt_REJECT
> > nf_reject_ipv4 ip6table_mangle ip6table_nat iptable_mangle
> > ip6table_filter ip6_tables hns_roce_hw_v2 hns3 hclge hnae3 xt_addrtype
> > iptable_filter xt_conntrack overlay arm_spe_pmu arm_smmuv3_pmu
> > hisi_uncore_hha_pmu hisi_uncore_ddrc_pmu hisi_uncore_l3c_pmu
> > hisi_uncore_pmu fuse rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi
> > scsi_transport_iscsi crct10dif_ce hisi_sec2 hisi_hpre hisi_zip
> > hisi_sas_v3_hw xhci_pci sbsa_gwdt hisi_qm hisi_sas_main hisi_dma
> > xhci_pci_renesas uacce libsas [last unloaded: hnae3]
> > [ 4407.076027] CPU: 48 PID: 610 Comm: kworker/48:1
> > [ 4407.093343] Workqueue: events page_pool_release_retry
> > [ 4407.098384] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > [ 4407.105316] pc : iommu_get_dma_domain+0xc/0x20
> > [ 4407.109744] lr : iommu_dma_unmap_page+0x38/0xe8
> > [ 4407.114255] sp : ffff80008bacbc80
> > [ 4407.117554] x29: ffff80008bacbc80 x28: 0000000000000000 x27:
> > ffffc31806be7000
> > [ 4407.124659] x26: ffff2020002b6ac0 x25: 0000000000000000 x24:
> > 0000000000000002
> > [ 4407.131762] x23: 0000000000000022 x22: 0000000000001000 x21:
> > 00000000fcd7c000
> > [ 4407.138865] x20: ffff0020c9882800 x19: ffff0020856f60c8 x18:
> > ffff8000d3503c58
> > [ 4407.145968] x17: 0000000000000000 x16: 1fffe00419521061 x15:
> > 0000000000000001
> > [ 4407.153073] x14: 0000000000000003 x13: 00000401850ae012 x12:
> > 000006b10004e7fb
> > [ 4407.160177] x11: 0000000000000067 x10: 0000000000000c70 x9 :
> > ffffc3180405cd20
> > [ 4407.167280] x8 : fefefefefefefeff x7 : 0000000000000001 x6 :
> > 0000000000000010
> > [ 4407.174382] x5 : ffffc3180405cce8 x4 : 0000000000000022 x3 :
> > 0000000000000002
> > [ 4407.181485] x2 : 0000000000001000 x1 : 00000000fcd7c000 x0 :
> > 0000000000000000
> > [ 4407.188589] Call trace:
> > [ 4407.191027]  iommu_get_dma_domain+0xc/0x20
> > [ 4407.195105]  dma_unmap_page_attrs+0x38/0x1d0
> > [ 4407.199361]  page_pool_return_page+0x48/0x180
> > [ 4407.203699]  page_pool_release+0xd4/0x1f0
> > [ 4407.207692]  page_pool_release_retry+0x28/0xe8
>
> I suspect that the DMA IOMMU part was deallocated and freed by the
> driver even-though page_pool still have inflight packets.
When you say driver, which 'driver' do you mean?
I suspect this could be because of the VF instance going away with
this cmd - disable the vf: echo 0 >
/sys/class/net/eno1/device/sriov_numvfs, what do you think?
>
> The page_pool bumps refcnt via get_device() + put_device() on the DMA
> 'struct device', to avoid it going away, but I guess there is also some
> IOMMU code that we need to make sure doesn't go away (until all inflight
> pages are returned) ???
>
>
> > [ 4407.212119]  process_one_work+0x164/0x3e0
> > [ 4407.216116]  worker_thread+0x310/0x420
> > [ 4407.219851]  kthread+0x120/0x130
> > [ 4407.223066]  ret_from_fork+0x10/0x20
> > [ 4407.226630] Code: ffffc318 aa1e03e9 d503201f f9416c00 (f9405400)
> > [ 4407.232697] ---[ end trace 0000000000000000 ]---
> >
> >
> > The hns3 driver use page pool like this, just call once when the driver
> > initialize:
> >
> > static void hns3_alloc_page_pool(struct hns3_enet_ring *ring)
> > {
> >      struct page_pool_params pp_params =3D {
> >          .flags =3D PP_FLAG_DMA_MAP | PP_FLAG_PAGE_FRAG |
> >                  PP_FLAG_DMA_SYNC_DEV,
> >          .order =3D hns3_page_order(ring),
> >          .pool_size =3D ring->desc_num * hns3_buf_size(ring) /
> >                  (PAGE_SIZE << hns3_page_order(ring)),
> >          .nid =3D dev_to_node(ring_to_dev(ring)),
> >          .dev =3D ring_to_dev(ring),
> >          .dma_dir =3D DMA_FROM_DEVICE,
> >          .offset =3D 0,
> >          .max_len =3D PAGE_SIZE << hns3_page_order(ring),
> >      };
> >
> >      ring->page_pool =3D page_pool_create(&pp_params);
> >      if (IS_ERR(ring->page_pool)) {
> >          dev_warn(ring_to_dev(ring), "page pool creation failed: %ld\n"=
,
> >               PTR_ERR(ring->page_pool));
> >          ring->page_pool =3D NULL;
> >      }
> > }
> >
> > And call page_pool_destroy(ring->page_pool)  when the driver uninitiali=
zed.
> >
> >
> > We use two devices, the net port connect directory, and the step of the
> > test case like below:
> >
> > 1. enable a vf of '7d:00.0':  echo 1 >
> > /sys/class/net/eno1/device/sriov_numvfs
> >
> > 2. use iperf to produce some flows(the problem happens to the side whic=
h
> > runs 'iperf -s')
> >
> > 3. use ifconfig down/up to the vf
> >
> > 4. kill iperf
> >
> > 5. disable the vf: echo 0 > /sys/class/net/eno1/device/sriov_numvfs
> >
> > 6. run 1~5 with another port bd:00.0
> >
> > 7. repeat 1~6
> >
> >
> > And when running this test case, we can found another related message (=
I
> > replaced pr_warn() to dev_warn()):
> >
> > pci 0000:7d:01.0: page_pool_release_retry() stalled pool shutdown: id
> > 949, 98 inflight 1449 sec
> >
> >
> > Even when stop the traffic, stop the test case, disable the vf, this
> > message is still being printed.
> >
> > We must run the test case for about two hours to reproduce the problem.
> > Is there some advise to solve or debug the problem?
> >
>

--0000000000002f0a6f061e871340
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHrACvo11BjSxMYbtzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODE4NDJaFw0yNTA5MTAwODE4NDJaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVNvbW5hdGggS290dXIxKTAnBgkqhkiG9w0B
CQEWGnNvbW5hdGgua290dXJAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAwSM6HryOBKGRppHga4G18QnbgnWFlW7A7HePfwcVN3QOMgkXq0EfqT2hd3VAX9Dgoi2U
JeG28tGwAJpNxAD+aAlL0MVG7D4IcsTW9MrBzUGFMBpeUqG+81YWwUNqxL47kkNHZU5ecEbaUto9
ochP8uGU16ud4wv60eNK59ZvoBDzhc5Po2bEQxrJ5c8V5JHX1K2czTnR6IH6aPmycffF/qHXfWHN
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBOY3N3qRb3ADhjA8y3vNuFAp6gX
0qqObGLUnxcjA6Y+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDczMTA4NDIzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQASHpbFFtWGAnBFypRLykidX0XDv8YOq6iGz0yGFzf4fB3k
KYsD9XQv6vnVFy0NAz8W+QXWQ6EiS/YEAzgZVdn+ljGwkCgysJljRkqd388NYS1QVYetHnfgbw78
lyrRLYjxnejTGD79fr3zUccQdZ4Cwy7FQFFPW2K/Ju/7kCWF/M/SlGvqB43VAZhSB0bj1VJe7JEc
1I4l02/9M4W2YgLLbD9Tmm70NZT4Aliefg5xf6I6bb9A/BxtNFHoKa5PN7vZIO2YoBjyvxuZZHmx
KSppAl4VWZt7XHg3ViJkqLjS+5n+3V1QmUrkU+Pc4OIbYf6JxcMZ79T/EG4KbZ5Ll5lc
--0000000000002f0a6f061e871340--

