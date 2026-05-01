Return-Path: <netdev+bounces-283313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CORYENc89Wn1JgIAu9opvQ
	(envelope-from <netdev+bounces-283313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:52:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A834B064F
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F293301C166
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B914037E2E4;
	Fri,  1 May 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCSuiiD6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916ED26C39E;
	Fri,  1 May 2026 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777679569; cv=none; b=d4XyBdjKWExIp9kloRrJltLoeiPnCZDHNQMvokJivpb/tPCahlwm7VP6fTcXbuS6/BUJqFevS5eDOeZr6NFtqchsAppLS+UXCAB07BBA0Pv8MzARusZHAHx86MMyszs0EfhC4UgpFmkySQVaCK2t7pAap8Zcq2C+jloXY500uV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777679569; c=relaxed/simple;
	bh=FX4PXwR541nk9lqlpg4ZyWwJ0QQeR085TUZDYDxe0JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMQtEsEYmBuI7C9Spfx8eO/xWZoS6dbZXmyHhuvN9vmhcdGRiJdMWlFsRehh2/OIGC4spX/N3Qpo0690u/C8iUQGlajs0tCY/2q1hWOhmLMaXcriDvX8My/IF1IwlcMy+2Iu5EKKH7WCNl/VbIVqB+J/QKAYmSRrJADbNJ4o0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCSuiiD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87969C2BCB4;
	Fri,  1 May 2026 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777679569;
	bh=FX4PXwR541nk9lqlpg4ZyWwJ0QQeR085TUZDYDxe0JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qCSuiiD6ZPC2W9yrDUa+OApu0jbE2HOK9AwTbkyBPuov+iVJ7IYUQRGDc5hP/azYQ
	 v9Rj3bXmv/4WuEPoTbWCl9QzCk6m7hNXjaGB96nf5nmM39b7sgyOaVAoZ31dE9efTV
	 ZuKg8RqfOtpPXU1tr1Uo2/WgZuKs/rjZWdcKMiONlM21sOJbQ9rcDG+2hyXJKqaDtG
	 PIXHHh0tBvGhlM/VwmVn2ZSiEdlhUmMKkZ903eUGWTo6j4Hjri7W0gusynCM1L+TKc
	 VQjnqsrsXSYzKjypOHrwcHHcB8zSSI/2P2H3dhhXz5GDQk0vvou9+98QaCiZuf/+dG
	 1RvD1ZSMnZ+vg==
Date: Fri, 1 May 2026 16:52:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Hongren Zheng
 <i@zenithal.me>, linux-usb@vger.kernel.org, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov: refactor common handle ID into
 kcov_common_handle_id
Message-ID: <20260501165247.7ed4511f@kernel.org>
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99A834B064F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283313-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com,googlegroups.com,linux-foundation.org,kernel.org,linuxfoundation.org,zenithal.me,vger.kernel.org,redhat.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]

On Thu, 30 Apr 2026 16:15:33 +0200 Jann Horn wrote:
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

