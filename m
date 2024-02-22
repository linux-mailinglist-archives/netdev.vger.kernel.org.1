Return-Path: <netdev+bounces-73950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8E185F6AB
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 168C9B23463
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3964437D;
	Thu, 22 Feb 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOLCZ01y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF833770E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600983; cv=none; b=pIhdKrKiJfDCUfi/X6oWOQpoX3sblAPXAhM77AYROjWOvijAU4Vb8VFjw3wPfPNbshaAqeK/BAZ674ViJTMcEBb9LWiyMRHu3PI076Oqq2r87L4VmyEt9+SMKB/SW1eo7oxwQB5cNXSKDezuLg/2N97Xlt73WbviaE9YWuKbEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600983; c=relaxed/simple;
	bh=kiARv1ZBg2ZOvG/2KzwQ25EcPbCJ0lXoejml9/wy3fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rDEmAMp2q8AZQptEQ5P+QEOnTQC3fEmsLap/LJLVkmIOCawHoflXyj+l3nPwdKv1bi3mroV+kDMZ7rhOImBa1U0wtTXftSK1r1iI8HYKFkGXMmUheN8NAQAWsWV6OVhM1TyrJUdajU7tOhN2IxnGzVMIqSsg59d9fr50zrbRG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOLCZ01y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708600981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiARv1ZBg2ZOvG/2KzwQ25EcPbCJ0lXoejml9/wy3fc=;
	b=KOLCZ01y3sfH8FNbCbVWlmAuLKfUR+v5rDU6G6GLoo3lPh0PtbvLGnd7JCVWEf0Oup4s0N
	iOYT/fJexX6lNQNaI+OzbDtqzQDVthw2GRdV5DwuEkK5Epnc9ZrNA+bcsTgRNUQIMRzjrH
	labNe6+fIw7qF6FFij9gcZqSYAROz2I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Z5g7NbCiMvKiNfkFlWOpRw-1; Thu, 22 Feb 2024 06:22:59 -0500
X-MC-Unique: Z5g7NbCiMvKiNfkFlWOpRw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3f9c6a4b44so13335966b.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 03:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708600978; x=1709205778;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiARv1ZBg2ZOvG/2KzwQ25EcPbCJ0lXoejml9/wy3fc=;
        b=d+8XYNYCeuDxwVNX6TAhqLmDOVPmhCllHriRHeTh7MJ56dz7rH8pRb0iiPueUG2cqI
         u2I+5gOmXpNJ+l9aFq6AWKlR7FHDghkZjWvIpoNARvxrjwReCx5ys2Xl0vsBeEaqSThp
         Ezjt72T3cFeOdCfn4zVs48Py1UogBN6rYZLvE111SkSUs+t6fWKeZnr57+YSxBTXuRKD
         SaeCKREOsUGfe74hcYatrLWWWhGJaMMsvVQkGsmyiCQ4ai5GYYaTqZdYQ3hCEHVtcK8r
         7XWGcJd4srau//OmcxkXlkQdn3gY7f8i9Go+5pXryoQwLqdE/XWXmpLBxuSIczUsuXz9
         G9/g==
X-Gm-Message-State: AOJu0YycrRhP67raE0cYnhb2DkZgiEJqafZvX7qfrRNsi9iHImxs6AK+
	fopAJiAl7YYZPixg8JpKxTPwPWWszgIOCGqK/Uop5cFON84oAOJjMiGm+yoazhnMMmoA2riD5Is
	U4xLHwhQRsPqZWmCtQhj/SC8qxWkTcTb71B6DBm8SXiBzREbXk99hAg==
X-Received: by 2002:a17:906:ac5:b0:a3e:ab9f:4129 with SMTP id z5-20020a1709060ac500b00a3eab9f4129mr7119771ejf.75.1708600978318;
        Thu, 22 Feb 2024 03:22:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxmyn3CtGsvmJiGrtqpNqtiCKkqzaMtpci+mZf2kJUGPAEIQDJyrgT71QA2e7okhpK9QAHjA==
X-Received: by 2002:a17:906:ac5:b0:a3e:ab9f:4129 with SMTP id z5-20020a1709060ac500b00a3eab9f4129mr7119767ejf.75.1708600978127;
        Thu, 22 Feb 2024 03:22:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id tb27-20020a1709078b9b00b00a3e502f5d3dsm4910126ejc.60.2024.02.22.03.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:22:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 029DC112DEDE; Thu, 22 Feb 2024 12:22:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 lorenzo@kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 2/2] selftests: net: veth: test syncing GRO and XDP
 state while device is down
In-Reply-To: <20240221231211.3478896-2-kuba@kernel.org>
References: <20240221231211.3478896-1-kuba@kernel.org>
 <20240221231211.3478896-2-kuba@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Feb 2024 12:22:56 +0100
Message-ID: <87v86ghhf3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> Test that we keep GRO flag in sync when XDP is disabled while
> the device is closed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


