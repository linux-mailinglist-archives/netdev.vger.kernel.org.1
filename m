Return-Path: <netdev+bounces-117421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0994DD8B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 17:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23C11F21416
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D915AD90;
	Sat, 10 Aug 2024 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Doqizf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0A3FBA7;
	Sat, 10 Aug 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723305316; cv=none; b=EE8BY8N6jOxYqr+lsA/xGMOjR7oerC4i00wr87AIFTL/yNtj0pzaBzcizfxQxhMHFsYI1TT5JNnxlnLnbRoreY2kiE1kWdwTwW/KYqJYCBuJD5WTK973xqZ6lLVIWf4xbjyRNTVjaeQdtTJeaBeebbtZijBwOh3w9qi9FMIi3tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723305316; c=relaxed/simple;
	bh=5V0zAGfH9jyn7ZkZUvjOM6Q4j/PtRye2pQe0OKFNNAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j27bfrsvpvvZg6BrjMigfiJ7A1KfxY3nJxsdK1HNOK+8JcPQpP/jjVTEgQDMOXWjq5swPc599ri6qqpHMKqoyEg4w+Y3uROiPOYPae7VMcnjJqXpQgIEh5u7BDB290lFB9D8DH9YCv1yB60jvHxkfpqgOCRBiFTecV1Dfg1QJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Doqizf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso2389004a91.3;
        Sat, 10 Aug 2024 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723305314; x=1723910114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NsrGSuD1JwGElXKXCp9CKeDOTjJCIjAdbtMoFt9rIDs=;
        b=P5DoqizfZDLAA9YAvXylFhJQdnO/uN1Y89CSjdXdeZDzBmiEmG9QatPANvJaEZo4oh
         VZMDT4vZj5JtjVWfS0kVRbig7PU1SMzWn6dJOsr9wwQqhPBAumdp+WsWwXIRzVlsPUzR
         wejmgl/g62KRru1p7xECYnbid3O8uKL19WWRGLHeHBkCGBOSPWB6NT7FehrgPWlVzj11
         NwRH1AavnyHPRKIpKZ10qPbyvRgEoxqS/3roQC4xcIUpnNbIodRnSyyYvgGVXuTGYNTz
         2q2rXA1sRhC1ODO6ADZT4xKCKJ/O3Uk9bfX+rEOn26q99SNv33HTRdHLTpeNR4G1mc3+
         IXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723305314; x=1723910114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NsrGSuD1JwGElXKXCp9CKeDOTjJCIjAdbtMoFt9rIDs=;
        b=qphdngUkxKlTBdB3XvLeNhZKfJZEvtjLyb/QHIWJK3RIvOzTSnDD+H1aW/4aFseRBI
         VeyVuAIo8sVAJbxkbmQLyfIXqMzuuQmLj6Ks107qElIwCJ65KgU/kGZ0/I5t4lw82DTk
         grY2txqUkNvW+lfeOK/vJXGmdTLT2WD1ImzE8gKPY7KWvek7J5ECT480XcauAewz5Wuf
         3BjCfcTOTme/VTteHTo7qlE9C9JEW0GuevdLmUAeeq5p4+GaqG3aG4K8NPNESQF2QKoP
         0dwveeyhmge5LMFEP/QLKhRhlMEuzABngtyxtNcsuv27Rl3vcP6SDPVreoJib8DsPeYv
         7mrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqJA/RFgFBQVuqCe8UixzwMY3TQvQsN1K3QQIy7BRiVJVEg0Bx1VHH4IleJg793U/b72D1d39wW3L3JTOtswQzSgXyl76HEmGx1/EM/V9cmVZhOcf0Tkv8kwxAHC8cMSs0V8ll
X-Gm-Message-State: AOJu0YxxsJa6N5t8sse1kBUqgWl4KsyT5Hhc5BQmmIv3LoFk/r8CR/kt
	3hWTQl7kf32CCLmk5c0grrim6PWdeu1XCvjz9RlXghs+cwH0Mb8Poh06jnQPg1/joLgktKMt25S
	vRLYRm45ag+O7FghOAeWV6Ru6hFg=
X-Google-Smtp-Source: AGHT+IECdVPHYVoLR83HwZIQDHuvtWvM0Nkn2UqCCLm17o/8mmDQdCg8ENQpzWlF1lQprIstUWaHnBoC4oMIU4XDvxw=
X-Received: by 2002:a17:90b:3cc3:b0:2c9:8891:e128 with SMTP id
 98e67ed59e1d1-2d1e7f9594emr5591559a91.4.1723305314230; Sat, 10 Aug 2024
 08:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810002302.2054816-1-vinicius.gomes@intel.com> <Zrb0wdmIsksG38Uc@hoboy.vegasvil.org>
In-Reply-To: <Zrb0wdmIsksG38Uc@hoboy.vegasvil.org>
From: Daiwei Li <daiweili@gmail.com>
Date: Sat, 10 Aug 2024 08:55:03 -0700
Message-ID: <CAN0jFd1CpPtid7TGJcgzajRXQ5oxYN1LjLjLwK7HjQ1piuZ_XQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net v1] igb: Fix not clearing TimeSync interrupts for 82580
To: Richard Cochran <richardcochran@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org, 
	sasha.neftin@intel.com, kurt@linutronix.de, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> @Daiwei Li, I don't have a 82580 handy, please confirm that the patch
fixes the issue you are having.

Thank you for the patch! I can confirm it fixes my issue. Below I offer a
patch that also works in response to Paul's feedback.

> Please also add a description of the test case

I am running ptp4l to serve PTP to a client device attached to the NIC.
To test, I am rebuilding igb.ko and reloading it.
Without this patch, I see repeatedly in the output of ptp4l:

> timed out while polling for tx timestamp increasing tx_timestamp_timeout =
or
> increasing kworker priority may correct this issue, but a driver bug like=
ly
> causes it

as well as my client device failing to sync time.

> and maybe the PCI vendor and device code of your network device.

% lspci -nn | grep Network
17:00.0 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
Network Connection [8086:150e] (rev 01)
17:00.1 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
Network Connection [8086:150e] (rev 01)
17:00.2 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
Network Connection [8086:150e] (rev 01)
17:00.3 Ethernet controller [0200]: Intel Corporation 82580 Gigabit
Network Connection [8086:150e] (rev 01)

> Bug, or was it a feature?

According to https://lore.kernel.org/all/CDCB8BE0.1EC2C%25matthew.vick@inte=
l.com/
it was a bug. It looks like the datasheet was not updated to
acknowledge this bug:
https://www.intel.com/content/www/us/en/content-details/333167/intel-82580-=
eb-82580-db-gbe-controller-datasheet.html
(section 8.17.28.1).

> Is there a nicer way to write this, so `ack` is only assigned in case
> for the 82580?

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
b/drivers/net/ethernet/intel/igb/igb_main.c
index ada42ba63549..87ec1258e22a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6986,6 +6986,10 @@ static void igb_tsync_interrupt(struct
igb_adapter *adapter)
        struct e1000_hw *hw =3D &adapter->hw;
        u32 tsicr =3D rd32(E1000_TSICR);
        struct ptp_clock_event event;
+       const u32 mask =3D (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+                          TSINTR_TT0 | TSINTR_TT1 |
+                          TSINTR_AUTT0 | TSINTR_AUTT1);
+

        if (tsicr & TSINTR_SYS_WRAP) {
                event.type =3D PTP_CLOCK_PPS;
@@ -7009,6 +7013,13 @@ static void igb_tsync_interrupt(struct
igb_adapter *adapter)

        if (tsicr & TSINTR_AUTT1)
                igb_extts(adapter, 1);
+
+       if (hw->mac.type =3D=3D e1000_82580) {
+               /* 82580 has a hardware bug that requires a explicit
+                * write to clear the TimeSync interrupt cause.
+                */
+               wr32(E1000_TSICR, tsicr & mask);
+       }
 }
On Fri, Aug 9, 2024 at 10:04=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Fri, Aug 09, 2024 at 05:23:02PM -0700, Vinicius Costa Gomes wrote:
> > It was reported that 82580 NICs have a hardware bug that makes it
> > necessary to write into the TSICR (TimeSync Interrupt Cause) register
> > to clear it.
>
> Bug, or was it a feature?
>
> Or IOW, maybe i210 changed the semantics of the TSICR?
>
> And what about the 82576?
>
> Thanks,
> Richard

