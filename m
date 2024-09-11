Return-Path: <netdev+bounces-127455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EB975764
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E8E283B7A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3641AC43E;
	Wed, 11 Sep 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYaQytwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350811ABEB8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069379; cv=none; b=pvUEt2u4zBLHmHQQVbxtUoCY9+nfwvTnxTZ26wXgHL2jZxYdJ9Ek9V7TtbIk1FfWqbs0so+Wvu5DkT92Y+ZiZPBfvkbah0n4jh/VZwkrLsdhACLncbb2AKMptU4S15VBEMlnm70Zsf2hdwH2Ay8MQ0jLscnQ79YhKSD4jWI8Hpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069379; c=relaxed/simple;
	bh=QH8GaE8kaSsepsUoV+eXuE8K8cDs0WMhBtrT7qPAce0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XdTMqbSGPVfrnJv5zpDc1Mztt0jkAQAayraPic4Muz3qTyjk6lgPD9Kx6OPyiYLffByFVFqAxmbHAKDEJ5sgEzR+nMQ0T/oAdlIpGU+XPjjKEiTmRxBvISLAC/5ti+UKsafz2A55FC9VKZtjFvl2l3xLcjSD1+J3egm58dkpkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYaQytwP; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e039f22274so2194423b6e.2
        for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726069377; x=1726674177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ygp0/gXnOtQf8QXqCAlJw/AXbuczfIEROwceXpOFVkk=;
        b=ZYaQytwPKDgdEQOl5ReSSZ7DlQk/afBXSl7g6YhQEZFPp7wIL9f3ryNdDYUwAP/1y4
         xvEyqq6enBDHnFX4b8PzQ5JavCBSOAWEPfLcbPqfQzVYTtmVElJ1SO8Tyhc99YMVyGSt
         YhmcO7lyq6pjWamEhC2fUBD7lSfKBhcIyo2xrg2ZTkI+OOxpcaxio7HaO23lvJZ8rrIa
         Sz/I0XoV4c/kndSJpBeCbWkxS1fnx/4xyb4o222S5eS11F9V9tj9yaZIGduj5DwSom7A
         djuw9aL1MVarCYx5pooIvBjo/N9VVnKhCaz0Uu/O+f8KFzxrD1O6NAV5HGpGhs712Ki4
         DXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069377; x=1726674177;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ygp0/gXnOtQf8QXqCAlJw/AXbuczfIEROwceXpOFVkk=;
        b=HzhbfpFjr9622x7iMD2yQBRlHQZrCFXHfM9BrGB6U45DMInohFnlpWFar7vbkovICy
         k8OKepbUM8NyIK5BtuiL/RtyYz/4vmAMcknOtVANNNczKllONjTq22v6dei3RHGQ+ONc
         9AOgWPcO210ntXXwuXV7sz77F8C/E/U4dCB8Y1VRnS6qpV6/h5Tc0OzG43VV1ZXsUc6e
         LfcEMSXE3XG5325v/3zPLu8ZOQp8AWkEj+GvGvX7WATVEy8HRF6byxDC04x8xczwUXnZ
         7Aj6PgtSvpV0RLdoBosAKJZN1sLR+setcOcSPkcvo1lTRH6hk+Gvju3m0QqOMqmtY00a
         Kxlg==
X-Gm-Message-State: AOJu0YzY0gKMs3czBX67VoAqQKNLHcnI1sKynBXSfPUKj+L0hJyKuS6y
	DlKgscbXjcrez41FvYoqs3O0WtkSt4DQRki8T/J9beAskUxm1AWJ
X-Google-Smtp-Source: AGHT+IGW5ZIBEFLjHNFQuU2Wzyix/gttjetzjnDZQ/HbVGTghNDJbdX7kEiMgfXsKCgI+2SUTFVW6w==
X-Received: by 2002:a05:6808:1a0d:b0:3e0:3552:9570 with SMTP id 5614622812f47-3e035529868mr11309084b6e.4.1726069377133;
        Wed, 11 Sep 2024 08:42:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e7ebbfsm42478961cf.26.2024.09.11.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:42:56 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:42:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guillaume Nault <gnault@redhat.com>, 
 David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 Martin Varghese <martin.varghese@nokia.com>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66e1ba805f3ed_117c772947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <5205940067c40218a70fbb888080466b2fc288db.1726046181.git.gnault@redhat.com>
References: <cover.1726046181.git.gnault@redhat.com>
 <5205940067c40218a70fbb888080466b2fc288db.1726046181.git.gnault@redhat.com>
Subject: Re: [PATCH net v2 1/2] bareudp: Pull inner IP header in
 bareudp_udp_encap_recv().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Guillaume Nault wrote:
> Bareudp reads the inner IP header to get the ECN value. Therefore, it
> needs to ensure that it's part of the skb's linear data.
> 
> This is similar to the vxlan and geneve fixes for that same problem:
>   * commit f7789419137b ("vxlan: Pull inner IP header in vxlan_rcv().")
>   * commit 1ca1ba465e55 ("geneve: make sure to pull inner header in
>     geneve_rx()")
> 
> Fixes: 571912c69f0e ("net: UDP tunnel encapsulation module for tunnelling different protocols like MPLS, IP, NSH etc.")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

