Return-Path: <netdev+bounces-224166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21470B81692
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDAA6466BCD
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A8188CC9;
	Wed, 17 Sep 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="j1g2PZ5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E5101F2
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135637; cv=none; b=ovFjuZpr7gH6UmMVapBTMAoq8D5YgwDEpjgEaxzxHfecRE4J2O5njMpC0Ho8DYZonscHanojtufJw+92S5rv39ZLzVgJAwcPNK17v6zB0tsBfnFD6JnjYmXOBLDOD1BJkhLXvn2Qb5txFrUO++aRE/myMzWlhryB6t/Oe/T/vg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135637; c=relaxed/simple;
	bh=qS9rOpPgrhiRNEXdjh7rR2q7V6xAfKFLPJSJ5vhqV+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvL/2+sbPC5j5TA8VddOzP58TMc/mFutAcPD6z6aPVu4LTMDwytmzASaN987HLaKAaKx0f54iKW85KpYstqH9OjV/j4ZGBqKrY3QPxud40ltllXmh6cNn1HdNY1J5UbGWlGRYRc8i+HtCoFK0mV7Cek+UXY8FNuAoJpySRA3Ymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=j1g2PZ5Y; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-829243c1164so19749985a.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758135635; x=1758740435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV7B/5uJ3IdluIamJ32FZ7iMmMC8X0JhBy0EKPLXodg=;
        b=j1g2PZ5YLQX92d+EDlxVN8ixdMqEFcDY/Jocx4nLS8h5b7O3NdOXct/q5H7rwoGLZj
         SiVX80Ds1vHqCP/Amp2pstWQRZ0AHBIWJIzYRfJXHZuo5X/k8EgIp+M7x0ApAFO/wBag
         ZTAtqB2PUk28ci9lqk//m2M9znsMHlRjLLKEibqNabS0+RZlAC4rAWc90tXKozaKF/ZZ
         nZ4N64k+sQoUdCFsHAGmgjYzdrh0R7OXrbWSqTepwSeoZm2W+WNS5dvyLWgxIsDyjXnJ
         chtBcPVrH8qKvq975thIvdXY3YyIF2RI98we8AVmqajqJvm/2WejFVaLpH7fEaUbDqBl
         KDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758135635; x=1758740435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rV7B/5uJ3IdluIamJ32FZ7iMmMC8X0JhBy0EKPLXodg=;
        b=BSkw/dBMU0W4WjYVdzX1GkSHaA3zJACOEhkhSE7KyPpK6Y+WKwVOjARKfc8o59pkxQ
         dSdar824yW2KNaq8Sx62dxhu0SS3n1MRj8sJiljOtrMgRccBpb2DeU2U9XeHU57hrU7C
         eP1ARh0ALEhp7hViCwXngPRJhXPzbGAwHRSV1x0VMfDvfd//5yanfhwg4IWxWBv4OLCF
         UhqvtH7M5VaKphi4+2pVGG7Oj2KN0d0tDFMKFQvlsbdBZG7hsX9X9HZCpTXwRwrOMVKe
         8yzAUyJ7dLt7Zpe+E4g6Fi3txT5pTGSLu12801cfx5OF4W6c/nzjtOOwBArB4mDVZjdr
         LbPQ==
X-Gm-Message-State: AOJu0YwZh1s9TvxZAINoHilnUfiy0lwV1k6N/Nlbi6AuxULFjt5Pijv/
	q7FjFc1vdmyr9NtjfMQriqxIVAoE9S346tPQVhrwEbLlAih29SqskVDy6Z+0xOVmlYMeWDHqhdO
	mVajd
X-Gm-Gg: ASbGncuXAdSTIbs9xTY5kgPeej/qOl2ZXBfz8QCOunkCd6vihfqkOiRzfaBIL9sSsLB
	GQolx5YNAomY9DiNpi6L5CTw7eLq/kCpq9cR7RCCtKITIrswFZ3mEVpRDDV48Q29y60byTZm77t
	/PDHOMI3pGdNbycUF/PIHj0s5kGR8jfVzSHloQjPx2EMirU+A+onHk9wLD1QBiC895bhrM8w0pd
	5ulEUNhpp8K66phFRCNQj23mzsm0pQw6oSYIsJ4azJU7YTHud77wJpDMOdoFRyFYEwmtRKJFoTx
	WHfSCxJbob23YIjshnXnVfFgkZmpKoZbzsCSwjxdaE2Kl2OVNt5kQYLMQNzQbrodA5QRGsNYmzE
	YMcwTFD9e9CrjryC4kLvvDvrcuUtUcIpMdfAhZV3XyBI5BWRe4KTiY1d6FPPvsL8SsyUzpGb5Zt
	s=
X-Google-Smtp-Source: AGHT+IHJExSZyDF3E2fR2xUFnnOeVQys96ZXrMXr9n7rrnijgakQkcap+MAYlo3/d7F+GjK+x8dXSw==
X-Received: by 2002:a05:620a:468c:b0:7ff:f2ea:d38c with SMTP id af79cd13be357-831122f3b86mr308315885a.66.1758135634467;
        Wed, 17 Sep 2025 12:00:34 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda943b56csm2355521cf.39.2025.09.17.12.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 12:00:34 -0700 (PDT)
Date: Wed, 17 Sep 2025 12:00:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
 pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
 haliu@redhat.com, dsahern@gmail.com
Subject: Re: [PATCH iproute2-next v5 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
Message-ID: <20250917120026.7601b13a@hermes.local>
In-Reply-To: <20250902211705.2335007-2-wilder@us.ibm.com>
References: <20250902211705.2335007-1-wilder@us.ibm.com>
	<20250902211705.2335007-2-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 14:15:52 -0700
David Wilder <wilder@us.ibm.com> wrote:

>  				for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
> -					__u32 addr = get_addr32(target);
> +					struct __attribute__((packed)) Data {
> +						__u32 addr;
> +						struct bond_vlan_tag vlans[];
> +					} data;

Do not add unnecessary packed attribute. The compiler won't pad.
Do not use Capitalization on structure types.
You can just use:
					struct {

