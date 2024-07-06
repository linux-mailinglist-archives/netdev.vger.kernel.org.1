Return-Path: <netdev+bounces-109633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6749293F1
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8E01F21AA9
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E08871B52;
	Sat,  6 Jul 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSHpwpMU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91FC6F2F7
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720274601; cv=none; b=umzcJXWyf5jtFRshJt86hmaFo6Pv87K6iqVgeITy0tAvd5Tkh4lwtzu9p0MXljFsIQHrTJwj0T5K2a0SFQJcglOjGyoenyYK7iunMUFGLXqYV3yIyka10K12nuPhvDj7lgWXrls9GQr1r4DtbQMQBRrx1QDYdDlWPBEiHceRjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720274601; c=relaxed/simple;
	bh=v6nsGNfmeyDJ28wcaDc9FU9Y1Xu5mShznd9YT34xXbI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=EBp/j1loaLhEzd7FjGHm6IKic89dN0TEdVFSFLiNoO0xYTQpoGFlpPKhlbsTTL4B03V95bwW2XEW+Hfcx4KehhO9Dopxvaert5yL7n0W6pEtxoKbW/PkCO4HKYMbFV8Nliqb96c3cp6Do3Qf89d4zEvPqtTXS3B6EgK3yAcynHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSHpwpMU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79efccad5e1so85628385a.0
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 07:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720274598; x=1720879398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcwyIkPC6VSAaTIMgKkYzUSVd0hXkkLHklvt7fDgarw=;
        b=NSHpwpMU8XAB9fo07iXuDlI+i07z4gGqf5X4qpkNx7synSiLOk0T6N+l5F6qITm6KW
         5v95Ue9ubeabMIbAdcmdR++YPNIuvrpI2aGIoJ3WcSr0ekFkqmL9W1Q1CWGo2SDZV+e3
         qJ/O+QRGBHLmYWj3YIKkO/4QyLolDVWpR9ETT1f6BEdesoe9XL4y3kjrDSs7JuXAR40Z
         Dk0cZftbumfUOBMJbKQJ+Cqivoqm+CuWpiBZP6mdyJKeVx3/K8FkYKLZbpG2V9gwTfdC
         yNh0M0kuBYY1cVMLUtoMiqJT/maUSEBE/9UXlR0i21ebWxa2zPgtxIJKricILe8PSqSN
         Avqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720274598; x=1720879398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcwyIkPC6VSAaTIMgKkYzUSVd0hXkkLHklvt7fDgarw=;
        b=soNu4UJrWcaphE6D9zJ6oNSBxEeU4EagOkWDM/gjJ3ESNuosfJDNB8E74wkCX0F2tn
         QygMh02wyEprvXkIShhOd18NoComJj8FZDIyF1HiS/+scjqbZiGCEzX868zbEvYYi0mS
         DOMvjFxzAOh/ZrZC5Ae7LO/6VlVnXRkvBGtkpo415QS3tK7UeKpSE8sLd5e97GB+D9vy
         D40mHGGjIzCh9bIkj617Pv4nApkB59O1Vc1Y+yJeO/ew7KRrUacC9othb6ed+B3bTosS
         qePJychlFqHQQy81J52htrIBE/8Gp8JyLFRXbKwPdoRgJ0j+NtoYV3GHmmhvRBGSch6c
         PD+Q==
X-Gm-Message-State: AOJu0Yy2Nnf4JN1MRmem6GOxPnyZA6dEGTva6E7pQSSlyyom08NyQ1sO
	cdoKU0LHSpG2C3PljTSKCOK/CzfjLuLIpR7BP/UsynoFnvzO8Lxe
X-Google-Smtp-Source: AGHT+IGURTczWJa0tg+YZ/2rFqSUz56rHkHM8Sogl7MFUGCKhChOWL/4ttwhWsibsEBd620egJfObw==
X-Received: by 2002:a05:620a:a43:b0:79d:5972:a7f3 with SMTP id af79cd13be357-79eee2e3c27mr802111385a.69.1720274598290;
        Sat, 06 Jul 2024 07:03:18 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79ef86bcd2csm149326685a.135.2024.07.06.07.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 07:03:17 -0700 (PDT)
Date: Sat, 06 Jul 2024 10:03:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 petrm@nvidia.com, 
 przemyslaw.kitszel@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <66894ea59b910_12869e2949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240705015725.680275-5-kuba@kernel.org>
References: <20240705015725.680275-1-kuba@kernel.org>
 <20240705015725.680275-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: rss_ctx: check behavior
 of indirection table resizing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Some workloads may want to rehash the flows in response to an imbalance.
> Most effective way to do that is changing the RSS key. Check that changing
> the key does not cause link flaps or traffic disruption.
> 
> Disrupting traffic for key update is not a bug, but makes the key
> update unusable for rehashing under load.

This is the commit message of patch 5/5
 

