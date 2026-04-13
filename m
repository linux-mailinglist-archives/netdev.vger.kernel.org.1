Return-Path: <netdev+bounces-278112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NVzGoIF3WkZZAkAu9opvQ
	(envelope-from <netdev+bounces-278112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C703EDA7F
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F54B3006B50
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF533AE6E6;
	Mon, 13 Apr 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta/gv6tQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpcwSdvv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90096361670
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092202; cv=none; b=LI/qa0tah4m76qdmqlrVOU/ON93QstKQ+wXd+JqSQgt2iyFu3yFkNjevE4pZDPl1UE3TEKDLTRhS1yZNPJczQS/tHX33bLxmOeyB5fRJJQCHxG+UWW1aTQONQPVTsgebZAGSKU2tfcR36MbJoVp0coSLCyvlpbFbZb40BMPzhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092202; c=relaxed/simple;
	bh=pbpXMs7VXRZdtUynBjml+ZtskO/P0GLq4ZmlxeGlfkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rPOtG4o3bxzqcOevqxDupJMDB2bt5pUoxSfHQD+xyod1fRqCDoKy+T6evODmL2exLhDCohsjdIWhVd6HF9k/k4JhvtTCdILgiENZKsmDfTNgRfmpAuwoADyn8R0/XiWVxM8LV7DRPJn6uMqaeJBjSebD12k36H+BAKK0bU/teD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ta/gv6tQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpcwSdvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776092200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
	b=Ta/gv6tQaq/p6mae1ZRjxtla2IKyNQAPRSWjohJjxKeWUDeGdIFMED/RNYs7oVABknDEFS
	Q70yFrPY/Rpm8Gat8kbUDtCWlaybxxlluxC/lxabySf0Uf2KikroQ/a16/3//noQNtgcxi
	GVL5SUwJdiMcySdmA0/c2M7eHZtR+Nc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-F6TIpCl0MkyFMIOkUpgW1Q-1; Mon, 13 Apr 2026 10:56:37 -0400
X-MC-Unique: F6TIpCl0MkyFMIOkUpgW1Q-1
X-Mimecast-MFC-AGG-ID: F6TIpCl0MkyFMIOkUpgW1Q_1776092196
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9dff69b5aeso49058566b.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776092196; x=1776696996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
        b=PpcwSdvvcYdYcweFnLihPUMjvHV+dZzYnSmGYLtYm5GXCh+Q9dk2cLExty2TDIX5vw
         1ESaeQLkuX8vJKGhPGOcExqYAzulKzLaLnyVGSK6FKSYCQgSb1Qh1rrNxxVGFe/Y5Tx7
         +kiwn3XNtbcn5RpwLnD1+JZFqTSiII0u9SKuoIBPGtx4jEUr03WCZWKg4wnxfMeWMLwL
         hZRqQsLhjdMlyudBohLKOY6KYdy1za1coBxmyPVW1rYReMdN6zZUbr2PxzogzcOr30Aj
         zGsvQjL+BuQBLB9uVi8VOOvEbacx59IoeWWVLfbT2SxIgSbjN52EuB/eBr0k13eS2665
         tmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092196; x=1776696996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
        b=oDUwj4hGhnv3MYTjJrOWAoOJA5Y6yzK+yQqIYgW3jitRrHK4sUFRndx1lcYEvBRFSo
         QblEx1/+OVKbxA9UBuWEkYzj3rvA0cPDFk5spY5crW9mZ6hIpmKYJXqNgsV6IwB4TuUG
         Xul5pr8EvZDSgCI6nmDf1UNuBS9+DY4ohRDb9ztRfgIQUvd/ZIutjFAlkvgQuusowUzt
         YZpOEHYQc4BmFuzG+Pkj3WCDXbSfa8t7Gy+K+QwISnW7KckuOhMRpLS05ywLqzdYdRaB
         eWIWC/f227ypBBkhQzHsTQn9JVkpRp7U5UrPlvs06JTthcE0xltk7JhVGhH0OGER61iM
         nd6w==
X-Forwarded-Encrypted: i=1; AFNElJ/TsYuC7t9iGJRbopBlz8644gILhltvAQFcNyx8/t6krX3UGOG1MRDrLyGCW9/uxy5t4LOR4dI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyetKZtutjeZzucTVrYehee19rrCKTyaKug45velCMvzIPCxKpU
	hGOtnvhGFSpp6f/LjjWfcknDFnNwCXxGlgmOmAnJu51G1RUK/Eqrl1HrNLIuj6djHVnwzVIPSbR
	d0y7Ft4GfMnoYdUqkhEJkmygoU4AAIIwBeWFA/VRBy3xBYyvwBV/f2PCr5Q==
X-Gm-Gg: AeBDiesu/MtLT7MuRWlNdMP9xUolLUEJpsMWcPP4js+gonx7HDSbEz6QGUBH98XBl+a
	RnW/LoYaeg2jfX4WsPhWeXd4dwNpijEDajJe+cjkkq6G7IKs7vyPbp2HWsUWIA0aUYlVKOBkmzi
	1SN9HAquOxldNyEK1SMQENK4rVscnh2gez2dstPTfeZvRbqjRBD34UrWE0h6kjMaa7WiUSZKDjy
	PBcs5RVesRRDCMtno5GmuJdkAyM0vs0ZWyo7NN/S9xl4VuROEV0xs/1b4C1EyXPZg/lYuc+uo2+
	0vFzWKrDgVgB63Fa/BTlRzizQlROwDgD6bYz50RWxfjqJXxup7klUqkJvdDDCIurpy8kRN1zMxR
	2v39UrN2siWBOjRkifDTxbhc2S73p4o8T7nsw9y4nsvBgdrsojtdjeQtT
X-Received: by 2002:a17:907:96ac:b0:b97:b9d5:4ae4 with SMTP id a640c23a62f3a-b9d724b225emr771975566b.20.1776092195970;
        Mon, 13 Apr 2026 07:56:35 -0700 (PDT)
X-Received: by 2002:a17:907:96ac:b0:b97:b9d5:4ae4 with SMTP id a640c23a62f3a-b9d724b225emr771973066b.20.1776092195339;
        Mon, 13 Apr 2026 07:56:35 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c583asm311542966b.36.2026.04.13.07.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:56:34 -0700 (PDT)
Message-ID: <0f1690ed-d449-4b7a-b172-85af40e709f8@redhat.com>
Date: Mon, 13 Apr 2026 16:56:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
 <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
 <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
 <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0C703EDA7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 4:17 PM, Luiz Augusto von Dentz wrote:
> On Mon, Apr 13, 2026 at 10:11 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> On Mon, Apr 13, 2026 at 9:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
>>>> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
>>>>
>>>>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
>>>>
>>>> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
>>>>
>>>>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> bluetooth-next pull request for net-next:
>>>
>>> Net-next is closed for the merge window. I guess Jakub could still
>>> consider merging this, but unless you want it very, very badly, I hope
>>> it can just be postponed, as the PW queue is already long.
>>
>> This update includes quite a few new hardware supports. This is a
>> resend because the last one was dropped due to an invalid 'Fixes' tag.
>>
>>  Btw, I don't know why the entire PR needs to be dropped if only a few
>> items have invalid tags? Can't we just dropped those?
> 
> Maybe Im doing something wrong in my side, the issue with the Fixes
> that is that sometimes they become invalid once I rebase on top of
> net-next, which, afaik, is necessary to detect already applied
> patches. Or is rebasing is not really necessary and should only be
> done once when rc1 is tagged?

AFAICT, rebasing is needed if you have local patches not present in the
tree that you are pulling from.

If you e.g. send a PR to net-next, including all the patches present in
your devel tree ATM, you could avoid the later rebase not applying any
patch in your tree until you merge net-next back.

Would that doable for you?

Thanks,

Paolo


