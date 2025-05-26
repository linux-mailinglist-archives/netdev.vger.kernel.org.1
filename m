Return-Path: <netdev+bounces-193369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6CFAC3A28
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546CD172B56
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B1148832;
	Mon, 26 May 2025 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0JF/75I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0864141987
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242101; cv=none; b=Fp1qe3zZpXLpXwCWGJcVKf0wG6zJZPO+fRYsYFjcJzXoavtk4HeZez5KU/t44A85B8HnVo5f3smbRm03s2P0Qa/fweDFn0uOQ8numIDJHfdEtg38S16VR4i64xwKjrIpiXmKeGI46pcOFnXn8EdIowfTDu3iRVXquHRR0//WhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242101; c=relaxed/simple;
	bh=cz0hbK2/g6gtbYVfNqJJuObRlC6MBeF+5/kbNo2r/Yg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=HAHtRrBfNc3RPQyHtjFpr0A7GvCEKJ22CyztRevUspjDU7T4R4kZ0QeyWJFbn0T0FDImRKjApdcWRfpLawvHGV0yV2sSoUKChjtea9Pv0k88WVKunRsFGmqOaXXHPK0wt3twLdlm3OcW0mZQ0g9FsjmqBhXjA6OW8fMWGkWq6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0JF/75I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748242098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cz0hbK2/g6gtbYVfNqJJuObRlC6MBeF+5/kbNo2r/Yg=;
	b=J0JF/75I+afZDVw/DGwaXz7vAki0GlMET7offG0+F5OX5puM7Hd6OFaOxwI0EI7kjeWcLB
	hIy9QnhGr0KWDoIAjNzco2SHVOZZNSeLG2qsU1orzlnwKiVr2PHJnOSLcBryNCjvS/nlKY
	Hms2wecV4EFRcQ0uf+6u5r1gcRjF7Fg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-y1cXSxwLOPKeS51v8I7Cqw-1; Mon, 26 May 2025 02:48:16 -0400
X-MC-Unique: y1cXSxwLOPKeS51v8I7Cqw-1
X-Mimecast-MFC-AGG-ID: y1cXSxwLOPKeS51v8I7Cqw_1748242095
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4c8c60c5eso1108211f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 May 2025 23:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242095; x=1748846895;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cz0hbK2/g6gtbYVfNqJJuObRlC6MBeF+5/kbNo2r/Yg=;
        b=tjkQFofacGZLHdqTKwe3wmYIcOEJlgb44qRgIAM0Zz1SsZsEfbwSNZhU+Bu4+5B175
         UO5K3rElL+0GVu0MXVn6U1HUrBlPpF+9FCk7jG27vJ6Teh6Vaye2+KUPgP8iA+HfMns9
         DVVjJSkTsQ4Eo3rwphYDrEmxyh6/DAixSV+hsWoMZqlZU8JOEz7eLSbqtiUMq1EewIlO
         KVPmmlNbNg5Xn0r91FXOFQCU0dMggg9+KvB75OcBjKUwzmoWcRYCPnxmvaTK2mYa+SEH
         D/Y7Ob5TBtzT0F9luDz1k8ZDsrZjDYCUkTABJVUxlT/5zIkOn8Ib1o/K3FGhAw/AqyEE
         vH+g==
X-Gm-Message-State: AOJu0YywjtDdoPA/GB/Nywa58b3ouMhZO/tfEWHfsez71cw6yAtTTpWj
	7QzqA/i2vf9VJIBe0kLOWFrRl8P7I5zzlTKB52prTcShweLBRHVRYKicjP6UNIC5deuMr1evsKu
	g+KG0lTPPF+9rnUjW5LTy9c2mN+52N9BniEy9FiakGEo2Z2Q+YgSKJrwtT92rZkhZzvuLsXjvc/
	onybOY3Mp5SRqvsIrI+9f09V8htB1VNKcnk7oowaA=
X-Gm-Gg: ASbGncuaAJJgn3POSBSukzA02Vuia+nACd+vLwAbJPYX5GInlwfVdKXz989XpCC2w8g
	rumoLM22/gg+IMWcyA0IRFCloPjQ1msADgYLxCtB27LmmyRVDDuNA+7mhSMxP9NdDp760j3YE6X
	wO88LQ4AWqqFKrP8+bnyC43pvv+eCtDmDH6KQmtqxsb6b1fHIoUZ/6jas4s+HxzNqZT5ibUz91J
	+9SRd2Gb67ruMa4xG2lrv2RPotSC82T8ID6maC4J5QlR/tZOBR43KPl4INVXXWxYOXbwjysn+Ei
	hoE2CgADDzdaPZ8MfAs=
X-Received: by 2002:a5d:64cd:0:b0:3a0:b940:d479 with SMTP id ffacd0b85a97d-3a4cb49e26fmr6068112f8f.53.1748242095035;
        Sun, 25 May 2025 23:48:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1fw3o6lSMrcq3LmkZ4uVubtsktQ1tEpAh3bo8RGugNUv23sku79l5Ov680N1n7BAZFhGB6Q==
X-Received: by 2002:a5d:64cd:0:b0:3a0:b940:d479 with SMTP id ffacd0b85a97d-3a4cb49e26fmr6068093f8f.53.1748242094634;
        Sun, 25 May 2025 23:48:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d66a2de7sm3067658f8f.3.2025.05.25.23.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 23:48:14 -0700 (PDT)
Message-ID: <5d758470-ca09-44ca-9ce0-8cfcac213b52@redhat.com>
Date: Mon, 26 May 2025 08:48:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 netdev-driver-reviewers@vger.kernel.org
From: Paolo Abeni <pabeni@redhat.com>
Subject: [ANN] net-next is CLOSED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

Linus released v6.15:

https://lore.kernel.org/all/20250526050536.release-6.15@kdist.linux.kernel.org/

and as per our usual process net-next is now closed for the merge window.

We'll go thru what's in patchwork already, but please hold off
posting any -next material, or post for review/feedback-only as RFC.

If you have a fix for net-next do use net-next in the subject.
And generate net patches against net.


