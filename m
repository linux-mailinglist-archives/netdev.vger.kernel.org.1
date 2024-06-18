Return-Path: <netdev+bounces-104486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE82A90CAAD
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E349B1C2356F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5402F158D69;
	Tue, 18 Jun 2024 11:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaBZmvqN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212C158A39
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711096; cv=none; b=Y0M9eLrF9/7YuSn9wL+0HIuu4Z99vg3mUA5bRx4y7DnbRnlizdMrEDSv7nzp2ZuNySDlSKBacBERn0qElcV7Hm6I1venlRmef0sCOKspkA262DPN0xOhZW3seWg1Le2HS4ZNLzXmVxDboy7W5bQyCWEwYyuApLpiglVRk2bdtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711096; c=relaxed/simple;
	bh=AQEuhLJn7rWUvoYXrruogt0G/85WrsUMZt/T1sSqKVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRsrP/XRmEuMrcIJlDFozd33LFsXUaj6XNZLBNvqfN+lrFBxJCY92qmIs9LR/42LjZd397Lbflh3EKff46nUmgQtojRmRzx7AMtfomnCAlTuT0odVXoipVL0FGf++Z4yYSPt0h9ab/sjP031F2vPXFo0eD7Gd6b36ofJT9y+gIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaBZmvqN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718711093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQEuhLJn7rWUvoYXrruogt0G/85WrsUMZt/T1sSqKVY=;
	b=OaBZmvqNDzE1wJAhLoqTaeQVOTqfklrC9nr+Je6Rl1r9N0o6ePhLMjnk5ZP14+fIEo71YP
	J45PbrY63eDXrddpMyYry5wLGFRPFlNImbA8mMWEmOBgYIenvQas1IcqQEVI7gJ0miJ4xZ
	7xrgqD7G/46Zis07b/CaElDyPmiY0v4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-kzHtZtJZM4uDuRrwRtXZ6g-1; Tue,
 18 Jun 2024 07:44:48 -0400
X-MC-Unique: kzHtZtJZM4uDuRrwRtXZ6g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D926719560AB;
	Tue, 18 Jun 2024 11:44:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.152])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 257A83000218;
	Tue, 18 Jun 2024 11:44:42 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: improve link status logs
Date: Tue, 18 Jun 2024 13:44:40 +0200
Message-ID: <20240618114441.22828-1-jtornosm@redhat.com>
In-Reply-To: <20240618111505.GA650324@kernel.org>
References: <20240618111505.GA650324@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Simon,

I will fix them right now.

Thanks

Best regards
José Ignacio


