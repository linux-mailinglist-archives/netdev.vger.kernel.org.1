Return-Path: <netdev+bounces-12454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F537379B0
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C7E1C20D74
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C1515BE;
	Wed, 21 Jun 2023 03:27:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5717EC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:27:49 +0000 (UTC)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751194
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 20:27:45 -0700 (PDT)
X-QQ-mid: bizesmtp85t1687318045t2kan9yb
Received: from smtpclient.apple ( [122.235.139.240])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 21 Jun 2023 11:27:21 +0800 (CST)
X-QQ-SSF: 00400000000000N0Z000000A0000000
X-QQ-FEAT: KzlRZEG578mccfoTL7bwOT2KpLyTXlSAk9nMZIsnWIbdlaVPJu2PMuTKXzbh5
	XMm1rinfmKlx1wS8P65vtQ9y1TCsSjP+NMV5I6ypM7AmQOSISn4cTsRRWfRYGPXekgzj+7H
	wubQKYBGobXN2qtova1NletRJNUUSeZaVtGpynk/RT961URmbAEdUV2nEpctIKQU1BHoly1
	xAiLx3s4pqFwNtYDvplC1ue2wx28dbG6O2OR4DoHhBb5D2Xa5oJc/J1AHcVIOGKsygWd/XC
	abpjr1u2qHQkDPxqkTcJXzBbVUz5NEGAdc7Mdg1HDht6ss61clS8k3lrRG9hz2N1ya5HZoQ
	xrjZbbPafVG0tS7xfzN1KppWz/jMkH9Wd8A5bKp2pCSrAajcZwK9ZPKz300kQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 13119982321859429342
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH net-next] net: ngbe: add Wake on Lan support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <331e15f7-a27f-4229-8aac-16ebea952969@lunn.ch>
Date: Wed, 21 Jun 2023 11:27:07 +0800
Cc: netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <51580076-5994-48C6-8576-C5CDD5878422@net-swift.com>
References: <58725FAD2BC3AE85+20230619094226.29704-1-mengyuanlou@net-swift.com>
 <331e15f7-a27f-4229-8aac-16ebea952969@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3731.600.7)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> 2023=E5=B9=B46=E6=9C=8821=E6=97=A5 03:21=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> +static void ngbe_get_wol(struct net_device *netdev,
>> + struct ethtool_wolinfo *wol)
>> +{
>> + struct wx *wx =3D netdev_priv(netdev);
>> +
>> + if (!wx->wol_enabled)
>> + return;
>> + wol->supported =3D WAKE_MAGIC;
>=20
> What exactly does wol_enabled mean?
>=20
> You should always return what is supported. Which makes me think
> wol_enabled is more like,
> wol_is_supported_by_this_version_of_firmware?

It means some specific boards which could support wol, get this from =
subsystem id.
Generic boards do not support WOL, which is decided by hardware and =
firmware.
>=20
> If it is this, please give it a better name than wol_enabled.
>=20
>> +static int ngbe_resume(struct pci_dev *pdev)
>> +{
>> + struct net_device *netdev;
>> + struct wx *wx;
>> + u32 err;
>> +
>> + wx =3D pci_get_drvdata(pdev);
>> + netdev =3D wx->netdev;
>> +
>> + err =3D pci_enable_device_mem(pdev);
>> + if (err) {
>> + wx_err(wx, "Cannot enable PCI device from suspend\n");
>> + return err;
>> + }
>> + /* make sure to complete pre-operations */
>> + smp_mb__before_atomic();
>=20
> I've no idea what this actually does, but it seems to be used a lot in
> pairs with smp_mb__after_atomic(). Is it actually valid to use it on
> its own, not in a pair?
I'll check it.
>=20
>    Andrew
>=20
>=20


