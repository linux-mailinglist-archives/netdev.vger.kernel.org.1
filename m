Return-Path: <netdev+bounces-153399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08429F7D87
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47DC16E924
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2258E2248B4;
	Thu, 19 Dec 2024 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyBSLc2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0D6224B1A
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620493; cv=none; b=Hd52lKgOrYUUCvoSqYsh8dgyBp+8xbX0km8yiSOw/VJfn6rN3UpOhFFxsHmr/vgpIi9Y9H1SVqLjMh1tW+nXPb3jmbPUjW9DGT9JWg9g9UiSM8Ve7+ypRyMejJE0IF1M/T/4ereqt4EawzEvkivvy1eAo79J78HfZyjuqom1BhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620493; c=relaxed/simple;
	bh=cB4uDBZHX8+2Q4OcLl0RJkaSaPj0kflE8nHqsd33fjs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=p+o7k2QduAa/iOyrwlNjVU8+fheNgGEU8EcTGMOz2tJGXpCZiNOMce2Ac3Nh9izDeYFYsVos7XYWI4MHPoRFKRLubkhCfGKDyDFwrdcQsu04shK1yzBHqusN5DKlcgIBljy2Q32QiBGXPIGCFK8Kw7r0Ei1nhis6xfqiIqleP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyBSLc2w; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4678cce3d60so7608161cf.2
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734620490; x=1735225290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmG5yPAwJimVagbIlzy3QYFL/gbvegmXZ5hlAqrdtBI=;
        b=CyBSLc2wPYgMsYDm4PbEqNEhXNR86Fv6Yu7Y5hOaLEwzaCWRdEqNChJ172J/wWf9i5
         /hdyaYHWAuKoKffpYOTnPx2fqESRQAsWV4dBC8Q67wURNTyTV6GP1Mb1cLcwvn7Gf5JZ
         0joyLld6UTFPqyWt0Q6pugDpnxLEJ2mqXZPrUoCVa9FhZKKMuH8WrzlAAhU3dA30q9FE
         s9XDic0NTto5otYQJwO/dd3WgKVPv3o5pJxh8e9TAu4hKnIIouyMEJeC6gc1GO3OSma5
         /u+R86+UNs7oMo+xeIhnw/GKw1yQqW72oszK23MHNaiwv2r5/zdG/CeezWlehOtg1URI
         /Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734620490; x=1735225290;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MmG5yPAwJimVagbIlzy3QYFL/gbvegmXZ5hlAqrdtBI=;
        b=jXKfxPtl6+rX/xcFFL3+h4SR4cPqsf2D8QoIpy8zblFHaB20BkTktyO8EqdLY2rGJ6
         pVnxTuM78RqVEMz2B1guOAS/N+lZw7Vxi8haRVExdjhj7fiHiAeF5fTTUTF1ZZ8X5FH0
         2ksgRj8Dt1ZJvho2lKfiOOstAbl8EdvWgUul3u4BORZsHaz+N7lI3gXpc5/Kdrnxmwm/
         1RuQWus2Zhkbo4ChqNXMZUPSVwBKINP/wS7GjlGAZHVO7qwlCUDuKeziI4ahJ6SEwYQW
         yEd74RP2ZhlyeBPYuPw/yXuXxzgtDjQEHRka4LTLmUaSF5Ir0qaqH3PkfjVHVMFqErhp
         1YDg==
X-Gm-Message-State: AOJu0Yx9cDL1QLfsvtRYQu+gbwg9qk4lqMpZp9BmSBU3ZShcJjo61CR3
	oS1ZfPUgtamS2xuSfmUuVAOgxdVx9CUiloAipkohj+3hnZsImHjhK0Ulwg==
X-Gm-Gg: ASbGncsV+Mf9V0WK0eAspEGV2+LpOEemkF+ruKLQwwm2mQjYzXOdBJlUrgixHd4KFfi
	UgrGB3WiqZrECJfnZqyxvpkWigyKkjpLckW0j6VWmoln6Vm8kP1uYqafwdaBZuLoE2AY1L01ONT
	EIhN4gB9K+/Jam8VQ0RJixz6f0H8vJ/qPlctGuCZMwX0obVMADxl05eBrqXyZz8aChlVmoLhZSx
	j9UXXkuhwwUWPbujquDXMAlTAYagSFjeQInX283JaxqT8ugC/gV82KCgOTgPrmaaydaGSuHTrG+
	zjGKUXy0BFN+sx5c4H8wpeKa1asmNAluYQ==
X-Google-Smtp-Source: AGHT+IGcbJQmMdv2/L5QG/PihDrviubYJfkoAHws+kOELeBXr0OTca4+vHua2LQtw13KGxYVdmJoYQ==
X-Received: by 2002:a05:622a:1a1c:b0:467:5457:c380 with SMTP id d75a77b69052e-46908ec139cmr131097961cf.52.1734620490168;
        Thu, 19 Dec 2024 07:01:30 -0800 (PST)
Received: from localhost (96.206.236.35.bc.googleusercontent.com. [35.236.206.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2bcfd8sm54765885a.14.2024.12.19.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:01:29 -0800 (PST)
Date: Thu, 19 Dec 2024 10:01:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Milena Olech <milena.olech@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Milena Olech <milena.olech@intel.com>
Message-ID: <6764354958acc_1d0f5c29479@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241219094411.110082-10-milena.olech@intel.com>
References: <20241219094411.110082-1-milena.olech@intel.com>
 <20241219094411.110082-10-milena.olech@intel.com>
Subject: Re: [PATCH v3 iwl-next 09/10] idpf: add support for Rx timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Milena Olech wrote:
> Add Rx timestamp function when the Rx timestamp value is read directly
> from the Rx descriptor. In order to extend the Rx timestamp value to 64
> bit in hot path, the PHC time is cached in the receive groups.
> Add supported Rx timestamp modes.
> 
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

