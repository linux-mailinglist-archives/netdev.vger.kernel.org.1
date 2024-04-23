Return-Path: <netdev+bounces-90556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734F68AE7B6
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE5A28817D
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AF1350C8;
	Tue, 23 Apr 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dhSxRwQ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CDA134751
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878074; cv=none; b=qjV67DH6eb7tx5dsuDis6qOz/LtwcdqztxuQ7nB4f1hBkMMnL6KjZ+2TXUfTYMn70JMXfN0RaBQA19Wr8yzap5SdD62SBj5a7Ry9NDHhSSrvmJ8dn/ctnN/nxy6oHuf4HAZhdIa4Y/5nrox8JOhcPrtCQXbiuRCa/pS/bsRNnjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878074; c=relaxed/simple;
	bh=6sem3VYTVWh0Fl79DDsCCKWfhPKWGXnCRaLYJZ9oJ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNrd4PNQErujTuUgj8ElSSlBUnC1ZTZ7d4NbdAYPL352oIIFEjN8uNPbzHKXbXYVFmdb0IqWHKqVP/m5KuGaz50RqFuceOpPsKaQkEaTJEJjeyWapCWOFUewagNRJ5JJq1gfBaU5mYl6imame2rxmvkHdnQzAi2hhrlsf50swJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dhSxRwQ/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso4024742f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713878071; x=1714482871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1qmA1p4TjETBn8tLveLCfp0nlOJRrmTf789dX65XA5s=;
        b=dhSxRwQ/qqw3SrjCXB6OZlv1seI3cz3IXXTIPgNHKpyGC4ZOdwVmxNPX1BnoAOcprf
         jAJF9boaJBxLCP6w41NYnl9hWbtHjaJxEmN5FBgPe9/kFSO4SDbtdhTyEQkqUcePrRBW
         rTJSqpfdgoAD5mLrELL5flKSTdabCCUDDqnXUfDlGxSO/XsMfPmyGysAYn8gi+j6Yyg/
         Z1dsYo78098NoZoKCebSaxdyrCV9e6f/WXywYF2oXsE8Jh23Cqafa8sf/RO6xTfTXJMW
         JAcilDNKBXKuPlMoa6Hz+05Gk/rldrk60+yopH3DKgk1tnARZMaKBv1qYQhIeFzeTnvO
         tMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713878071; x=1714482871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qmA1p4TjETBn8tLveLCfp0nlOJRrmTf789dX65XA5s=;
        b=O4n80NnGv1iW9ru/SqO9F83+icNqhUXasoRnKtegej536m3943FKLmxUCgc79eBALv
         40pqQ5zej9E417/dQkOj7TDYpWynZooNfDuT5vPFWiZpojztgwTXfKFe6tNspYLFo8ta
         U9v+NmPhRAK1IH48emOeha+7Y69Oue0VoLzO0y7I23c/CucOOpR/Ytc2XgrTYQgB2SNq
         75Px15uybDc77es12mPkVT0s3zRdT1QtcLlweHP87xhT31bPFP/6akQCeojIXXQBn1ze
         dHxEkf5TVXiypt9OjpWGqz0hRVWTXm/uh8/kZyMrN/LAYCmpEt6OCEEsEHgocXBit/GH
         Lpsg==
X-Forwarded-Encrypted: i=1; AJvYcCUfGcCZHG6Z1h7Bd/mXWm+RP0K1HCZxTRDximHpAWann3ebL2yVD4V/wygfFgaDEnA5jihRG7vBGoR05LZtZESFJkOJ1C35
X-Gm-Message-State: AOJu0Yzu/Vt9kP/etHWHCR4df+CL5lHQ6gjrfvQFVhr0NH8i8btp6ZX7
	yi7Ha4usQ0jCfEhj7FJ+mMMtrWgLTJqDGvDAYUqWMkDn4jqPmpRX4W1MfY+TrIA=
X-Google-Smtp-Source: AGHT+IF4EPhB2yNAv8Dziy7d08f7B27xtumOJg9LPFpGkkeJRxZJJHQpmvHCWYjnxx424wL8nobBIA==
X-Received: by 2002:a05:6000:c8e:b0:34a:2da1:c556 with SMTP id dp14-20020a0560000c8e00b0034a2da1c556mr8585129wrb.37.1713878070900;
        Tue, 23 Apr 2024 06:14:30 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d40d0000000b00346406a5c80sm14619450wrq.32.2024.04.23.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:14:30 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:14:28 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
Message-ID: <Zie0NIztebf5Qq1J@nanopsycho>
References: <20240423091459.72216-1-sergey.temerkhanov@intel.com>
 <ZiedKc5wE2-3LlaM@nanopsycho>
 <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB468117FD76AC6D15970A6E1080112@MW3PR11MB4681.namprd11.prod.outlook.com>

Tue, Apr 23, 2024 at 01:56:55PM CEST, sergey.temerkhanov@intel.com wrote:
>
>
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Tuesday, April 23, 2024 1:36 PM
>> To: Temerkhanov, Sergey <sergey.temerkhanov@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Subject: Re: [PATCH iwl-next v2] ice: Extend auxbus device naming
>> 
>> Tue, Apr 23, 2024 at 11:14:59AM CEST, sergey.temerkhanov@intel.com
>> wrote:
>> >Include segment/domain number in the device name to distinguish
>> between
>> >PCI devices located on different root complexes in multi-segment
>> >configurations. Naming is changed from ptp_<bus>_<slot>_clk<clock>  to
>> >ptp_<domain>_<bus>_<slot>_clk<clock>
>> 
>> I don't understand why you need to encode pci properties of a parent device
>> into the auxiliary bus name. Could you please explain the motivation? Why
>> you need a bus instance per PF?
>> 
>> The rest of the auxbus registrators don't do this. Could you please align? Just
>> have one bus for ice driver and that's it.
>
>This patch adds support for multi-segment PCIe configurations.
>An auxdev is created for each adapter, which has a clock, in the system. There can be

You are trying to change auxiliary bus name.


>more than one adapter present, so there exists a possibility of device naming conflict.
>To avoid it, auxdevs are named according to the PCI geographical addresses of the adapters.

Why? It's the auxdev, the name should not contain anything related to
PCI, no reason for it. I asked for motivation, you didn't provide any.

Again, could you please avoid creating auxiliary bus per-PF and just
have one auxiliary but per-ice-driver?


>
>Some systems may have adapters connected to different RCs which represent separate
>PCI segments/domains. In such cases, BDF numbers  for these adapters can match, triggering
>the naming conflict again. To avoid that, auxdev names are further extended to include the
>segment/domain number.
>  
>> 
>> 
>> >
>> >v1->v2
>> >Rebase on top of the latest changes
>> >
>> >Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
>> >Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> >---
>> > drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++------
>> > 1 file changed, 12 insertions(+), 6 deletions(-)
>> >
>> >diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> >b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> >index 402436b72322..744b102f7636 100644
>> >--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> >+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> >@@ -2993,8 +2993,9 @@ ice_ptp_auxbus_create_id_table(struct ice_pf
>> *pf,
>> >const char *name)  static int ice_ptp_register_auxbus_driver(struct
>> >ice_pf *pf)  {
>> > 	struct auxiliary_driver *aux_driver;
>> >+	struct pci_dev *pdev = pf->pdev;
>> > 	struct ice_ptp *ptp;
>> >-	char busdev[8] = {};
>> >+	char busdev[16] = {};
>> > 	struct device *dev;
>> > 	char *name;
>> > 	int err;
>> >@@ -3005,8 +3006,10 @@ static int ice_ptp_register_auxbus_driver(struct
>> ice_pf *pf)
>> > 	INIT_LIST_HEAD(&ptp->ports_owner.ports);
>> > 	mutex_init(&ptp->ports_owner.lock);
>> > 	if (ice_is_e810(&pf->hw))
>> >-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
>> >-			PCI_SLOT(pf->pdev->devfn));
>> >+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
>> >+			 pci_domain_nr(pdev->bus),
>> >+			 pdev->bus->number,
>> >+			 PCI_SLOT(pdev->devfn));
>> > 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
>> > 			      ice_get_ptp_src_clock_index(&pf->hw));
>> > 	if (!name)
>> >@@ -3210,8 +3213,9 @@ static void ice_ptp_release_auxbus_device(struct
>> >device *dev)  static int ice_ptp_create_auxbus_device(struct ice_pf
>> >*pf)  {
>> > 	struct auxiliary_device *aux_dev;
>> >+	struct pci_dev *pdev = pf->pdev;
>> > 	struct ice_ptp *ptp;
>> >-	char busdev[8] = {};
>> >+	char busdev[16] = {};
>> > 	struct device *dev;
>> > 	char *name;
>> > 	int err;
>> >@@ -3224,8 +3228,10 @@ static int ice_ptp_create_auxbus_device(struct
>> ice_pf *pf)
>> > 	aux_dev = &ptp->port.aux_dev;
>> >
>> > 	if (ice_is_e810(&pf->hw))
>> >-		sprintf(busdev, "%u_%u_", pf->pdev->bus->number,
>> >-			PCI_SLOT(pf->pdev->devfn));
>> >+		snprintf(busdev, sizeof(busdev), "%u_%u_%u_",
>> >+			 pci_domain_nr(pdev->bus),
>> >+			 pdev->bus->number,
>> >+			 PCI_SLOT(pdev->devfn));
>> >
>> > 	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_%sclk%u", busdev,
>> > 			      ice_get_ptp_src_clock_index(&pf->hw));
>> >--
>> >2.35.3
>> >
>> >

