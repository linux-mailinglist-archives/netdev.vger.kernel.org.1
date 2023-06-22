Return-Path: <netdev+bounces-12870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E422A7393B1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FAD91C20FBA
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E5196;
	Thu, 22 Jun 2023 00:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E018E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 00:20:14 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D02EA1;
	Wed, 21 Jun 2023 17:20:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b5585e84b4so6498715ad.0;
        Wed, 21 Jun 2023 17:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687393213; x=1689985213;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIb6cEzl3Y1Hw+pztaSYaT1plChZ0U0JrqZCF4CrGkk=;
        b=h/m6AEKBQ/3phkcCVbiyRXUdVGHNumugdDl5c9PQMI8fyvvR2fZJUSF5TVurU5PoAN
         YarS5+TuIHuVHldFdwVzZ5MMOPRYv9+lRIMP95EdZHIqkIXfYQiq3Jjx5syvQZl1LURG
         E+hCPNJ1BMoYFGbzW5l0D/sZ06SNZmPMSNIRiZnTGLB8Ron5ba6G+VWaSeliJNjRaDbV
         XVYET/4uPnhlq4lpANB0B8+es0d+KVhck4cG+Ag3DgBY2mWGRor/4kfeYvSrclRVERH7
         pWBXB840QshD3eU2+UlSdcEi9iiuXbcQbJXfRIHevHV+lp+8JsdYVPTNfudL4caNg1Wa
         rVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687393213; x=1689985213;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIb6cEzl3Y1Hw+pztaSYaT1plChZ0U0JrqZCF4CrGkk=;
        b=YyeundaEaxByu5DebZbGUVirzhTjuUSaVO+JGEzOuflSyQ4q+CXXvcB98wVXoz9VRi
         fRF87QdQUytH7D9mDGkBeIYC2CUab90A3LibzIaDpkgek4RpGZidDgyxDfazka28y5KH
         TGm9UlDI9eWMdNgzyBD74nxNKrylunZAxWzp7pKoDEYQQZZsGqZTg5H8LIL/3sAs5RNI
         UzT+ViqQCVmuoP5p1z73+sp35TjClMqLU8pIZ+ISzXb7+PjYgbCq9ZoVAHL7i7Hij9od
         /xZy2ZhUvoUFzbM9Lg8W7KJhe3wAPS0hOxBThtOAETxur+1mNSmuOWdMHdVc9o3KFAr1
         fS3g==
X-Gm-Message-State: AC+VfDzuFHU22tXziVmbw9hFGKYrWMqnzir6Ciweu1TE0JkgKad5pvZE
	RPeZoTxQVFaaLhw9Ab/wqpdyjL20N887Flf0
X-Google-Smtp-Source: ACHHUZ5z9DFcqqXzERMCWQGwJJzp5ZHEP7Ee9CVWGFB12soS+1F/zk6H8ruZDa0UAXPh887GBCX8yQ==
X-Received: by 2002:a17:903:2451:b0:1b0:34c6:3bf2 with SMTP id l17-20020a170903245100b001b034c63bf2mr20442335pls.5.1687393212615;
        Wed, 21 Jun 2023 17:20:12 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id jn9-20020a170903050900b001b3d44788f4sm4080728plb.9.2023.06.21.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 17:20:12 -0700 (PDT)
Date: Thu, 22 Jun 2023 09:19:46 +0900 (JST)
Message-Id: <20230622.091946.732732192250039677.ubuntu@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, aliceryhl@google.com, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com
Subject: Re: [PATCH 1/5] rust: core abstractions for network device drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZJN9WmRCJU8nN9jE@boqun-archlinux>
References: <20230613045326.3938283-1-fujita.tomonori@gmail.com>
	<20230613045326.3938283-2-fujita.tomonori@gmail.com>
	<ZJN9WmRCJU8nN9jE@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Wed, 21 Jun 2023 15:44:42 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Jun 13, 2023 at 01:53:22PM +0900, FUJITA Tomonori wrote:
>> +impl<D: DriverData, T: DeviceOperations<D>> Registration<T, D> {
>> +    /// Creates a new [`Registration`] instance for ethernet device.
>> +    ///
>> +    /// A device driver can pass private data.
>> +    pub fn try_new_ether(tx_queue_size: u32, rx_queue_size: u32, data: D::Data) -> Result<Self> {
>> +        // SAFETY: FFI call.
>> +        let ptr = from_err_ptr(unsafe {
>> +            bindings::alloc_etherdev_mqs(
>> +                core::mem::size_of::<*const c_void>() as i32,
>> +                tx_queue_size,
>> +                rx_queue_size,
>> +            )
>> +        })?;
>> +
>> +        // SAFETY: `ptr` is valid and non-null since `alloc_etherdev_mqs()`
>> +        // returned a valid pointer which was null-checked.
> 
> Hmm.. neither alloc_etherdev_mqs() nor `from_err_ptr` would do the
> null-check IIUC, so you may get a `ptr` whose values is null here.

Oops, `ptr.is_null()` should be used here instead.

Thanks a lot!

