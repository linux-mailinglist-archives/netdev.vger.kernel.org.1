Return-Path: <netdev+bounces-232129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2703C0184C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E711D1892995
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FCB315766;
	Thu, 23 Oct 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lz46usbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F69306B0F
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226793; cv=none; b=DcTNBCVbu/V6l/tts8sMt6FveimGzwJ/46t8rxAmI0UNEs5etajuwSF5kpocbsVoCeQD1mBB4lurs9NsIwA72tPeUMbAL4jRUsnsQ9o3q9lyON504kIXUgqbokgXa2XQ8nDuMI8lL5skDBAiB9dk9LEgWKyrfP33H5RzBofP4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226793; c=relaxed/simple;
	bh=fL4QZgDs/7NgAJi+MUyoIDQZJZGE4ZYvUJdGj7MnbuA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qJietAC2qF+elDZBf/Ikxh9NrbCfOUaRTcDf509hxJ2b1Piq/6jXcX//xjj+fNTjj+Dstbia0FuSZQmeETbmUU5SC3hcOf03dMwoiTaCyoH//n/OXZ/qx/8l2BZqRS0IkoCO4aOFnPqds532DJi9/OoioDFcu+nryqYY3dcO58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lz46usbT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-879b99b7ca8so8968286d6.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761226790; x=1761831590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTypga1qCEmyQiglkVwWSiPZUXfVtnyNwHGfiNq7yLA=;
        b=Lz46usbTWYodLxGTpv+W2S2Y0wg9/sOeJ2j9S3kabAgcmFMMAIcaRtiEaUf9Lfqx3V
         HXWdl7/jzOT2lmVHdlmllZ8XDxS37CJYVR3fxFpknnegVviH8AwM5FuWFmNVUSYxyqXs
         TAoYVN9DDdYaLdI1ovA0QsCyNc//ksMO8mA0u2hS+0X4TpjgHce1OKIsHYmvb4JjuHUn
         N7hMtEZISXUUBN1sLqI+OrB0gN6OzNVhW9M/jPfRCXIarBBE/Njlu/3rpOyJwUVtdK1b
         IU8AweVeYWJy7l2n87qhzIG2jKi+5KRzt918gLuZ4wYC8zZA457gUp2SH62Ft9Y5TO49
         H7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226790; x=1761831590;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bTypga1qCEmyQiglkVwWSiPZUXfVtnyNwHGfiNq7yLA=;
        b=vacphL2vtHr4isN7427Wocl1gPAy4HsHLc/QizSQU2YpD75GvFc9XW1LOwAzdfZ2KM
         wfMw6A+RA+D0DQ057aDVQjDSPXAmTQjn5Imbd+e8gK66Oir8VsV0Z1ZGheuOheOBf1st
         1QmbTddJaf2sAzSSM11WndgkvtGdKJH14eNAEguH7Wq/zzVLonFbBIPN4RNxA3KFI2fi
         1BmB8dSdqfz/+5sM1TVqWtIbyTh6+UvWGzwaWsfH1Oo6DmnDrzU7w1NF+4CkR9XZKBil
         dILaqL0Mou1g/FRdBTYfpgV39DJNcZWPU56gHlWEQswVNxMTGGdQwroKDyM+4pZSa2zt
         9bXw==
X-Forwarded-Encrypted: i=1; AJvYcCUrxSe24Da7G0nULrMt5WUgkwGGW5fXzVnYl4/FC372dmzJ1lupa0L/ULSkjyDHwPNOMsrLKiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAN49KTjrle6D6MOwVyhDhiYPKm0aA7Ru/mb6vsdaWsPobrKkV
	9mlsCEvfoEFzDXsmjJGnQRpV5xAT4Uc+FpTAxeyKN6003009grvHPlFP
X-Gm-Gg: ASbGncshQjObkknnXVjXJ1WogUmGwZMRSN+CR7K30kIo1ioSmFoUHT/ptqTdtVdk03F
	t8dYvnmr4v/Eg10SQRjl+zBtvqHivsqfWr4N4K6NvhI2Oqmd3mQtqQlac+dWIZzvTQ3FuiKePP3
	BDXuoaOB+iMUuxDsB75P75W0PZdQzJVmf61Boe/sw+r/LWmzgwkqqfgfBIPRk/1LXkDcnzV/prT
	3FertpCh1QdVW9BP2gQi1cn1ftcx1hrD6Yj7N7KM/EZITlp8j6CpB3zM7eyn2gdz+8DDIFK0PCM
	4iYsWVEHpAcNwO6BrBF2co3OlWcHPMZCEO00LMIE7Ax6aXBdo0cv1+8qUIq09By1QDy3g6U93h9
	pVljouHEOzFaMzk+KFNKy8sAJtAqtsgYIs1vb+IccrtdpkWwt7DwhU9Zp1cmfz27fyUthHr60uP
	KOzPNS2dcMzavh8vpJC9U3HUsYigp+p45IgCIHqREx7D9VpSAgpZI0NecRpEtRyzo=
X-Google-Smtp-Source: AGHT+IHAVtlHeEm9UD2xS21XDKeblQvAi36dUAfJMFenvYq27aN9MyQI9MGK615QNj4pEMIDInYZSA==
X-Received: by 2002:a05:6214:248b:b0:804:9bb6:fe77 with SMTP id 6a1803df08f44-87c207f2a88mr301676956d6.49.1761226790204;
        Thu, 23 Oct 2025 06:39:50 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87f8fb6d2d9sm15183786d6.3.2025.10.23.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:39:49 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:39:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 horms@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 daniel@iogearbox.net, 
 fw@strlen.de, 
 ishaangandhi@gmail.com, 
 rbonica@juniper.net, 
 tom@herbertland.com
Message-ID: <willemdebruijn.kernel.e817f4414e22@gmail.com>
In-Reply-To: <410cd787-0085-4409-97c1-2019a7baab8b@kernel.org>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <410cd787-0085-4409-97c1-2019a7baab8b@kernel.org>
Subject: Re: [PATCH net-next 0/3] icmp: Add RFC 5837 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Ahern wrote:
> On 10/22/25 12:53 AM, Ido Schimmel wrote:
> > Testing
> > =======
> > 
> > The existing traceroute selftest is extended to test that ICMP
> > extensions are reported correctly when enabled. Both address families
> > are tested and with different packet sizes in order to make sure that
> > trimming / padding works correctly.
> > 
> 
> For the set:
> Reviewed-by: David Ahern <dsahern@kernel.org>

Same

Reviewed-by: Willem de Bruijn <willemb@google.com>

Based on answers to my questions no changes strictly needed.

