Return-Path: <netdev+bounces-241597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E5EC8643B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59C35341A08
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07265329E60;
	Tue, 25 Nov 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ+ldf+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69518FDBE
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092564; cv=none; b=Vc7LFXSWRYsuxOE2a2wJlOUrxZZmci0CLpHSuvc0Un/nyzvaF2+a/Q1CWNUqBJOl4Ppd16kfgfl7DeHtnp4XNByzfq6Xr/1oLr6acB+6fzippWpAmWpydGfPhpxJvryAev9xCAA9rs1aOkZ57wwDhvvhT7y2F0IKRpkF1ciZal4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092564; c=relaxed/simple;
	bh=y4tyX8TPr8Fd4sNfx70JolFLTf3E7Kwk14TnfD7hLbA=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To; b=XJL5RxPRBzE6dMjEWSmnoFmMzdcmFABIJCwvyewtC3UHssogIV3tEkVWrNNeue0zENhWlQEEFZ3geG3rKgdwmlLkJmjnF4PdIIXFoNPXXKzynFX9ELeEQtfAOnUREIuD9lMIIwfDy7sKAKyh01UiB0aqqKw/jct1JxRJh5bU4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ+ldf+7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298456bb53aso72539065ad.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764092563; x=1764697363; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4tyX8TPr8Fd4sNfx70JolFLTf3E7Kwk14TnfD7hLbA=;
        b=iZ+ldf+7J+48YlNUr8gtiuj+IDnbVTjyVO8IkfbT5A74/Z0IO4Y7bprWNkOp+ss7ob
         skbsxGrfo+svDMi/vq1EJSlFcEbzydnTQPwp8tKWW9q5K5zGE/EnnNfrIHqh8YEci/jA
         o2LohtOwLL6eaza3NEonhO7RRHVIvct+6IyDXWeFRhi35FufVXWp36VHZTU/6mmcWUlU
         vnlEIE97cZzP30MVF2ioaiFPcWLlEHzdr6DJIDu+MX8fMyb8k5oBCXZ/FcOQdJNJB1SW
         J7b05+EXHnrAxCtaOfwg37OWv+SAcTKkaL6TiuPQ6koIcusjYtiqTX3wMi6/JFwD0IuB
         DDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092563; x=1764697363;
        h=in-reply-to:from:content-language:subject:references:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y4tyX8TPr8Fd4sNfx70JolFLTf3E7Kwk14TnfD7hLbA=;
        b=E+3349ckudNBGzOi72Ur/0vBf9p0oJEfanQv2vCbzHq+EQuaEwGJew/7kltPaE71TO
         kaUmowxthFuVozOeA2Ynj2uCcv9XD5AhXf0luKgH4jMarhBjBsY84s2aWx+5weqKy+Oy
         lWW+nxGDBZTGmdBzQcV4N9Kz+h5Pczqo3jf03kR8KYj799hoj1QclfIrKQBsvZwJdDAs
         QjjfYv9L/3aKZdIYYmcwL8juMgHNG5OFD9hv/iHBRWFyODm38U40UIaoLRj+FrgDdoo8
         XpJvjIBi4CZyAd9C5DAYlgWrS0svYcEOhQ1lq6GOZaTKNNTTRk6OBAmiykeD+dkU/044
         Bvgg==
X-Forwarded-Encrypted: i=1; AJvYcCU4NbxYo3xxYnPqxVi3RVIVqfRhbfbbJ3Kdz4BjsPsIynz018cFv+EF4DggLfAM78K4pObhbeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1t2FX7agjipSZoX/mCyI4WzAb/A1dh2we8SBE6295aQSU1cro
	loYrO7QEdBvolxWIv04cWF3GCHlCqOswF9vVOUZb/P9Fb0Xk9EddPB5h
X-Gm-Gg: ASbGncu4hcMoe3Pd4pSNQAUyGel7gT27ooDtfjZy2tggYkatiEA9BuWb+xGiIwKD//A
	wbMeXR0msD2Bkaj2kpuCGOv6NYOhoQWfp/rsETlu5yZtWdSQn+4qDbAKG8bxIUNeMp8p3M+SM3j
	vuymNQ92MZlsIIhRtMQmTzpyzy023lrzzb7Eh8oZNgdfInS5AkX3WeRII98jIuG0T8Jus1yrqb5
	jr3xwBkinHO3ddLdbffsOy0lzQXllpRptpFlbYoZYR4kxlf7Pd7DEDopEpGz512GRRRAmheGl+4
	IAIf3GlEth1hajyNV+hM7vWg6hkQH+JzEJ1YB0MYhHqTNyNR772tEfmj7KvHo5FC/46uCuK+XWV
	fwXYgzoxC6Edl5dHezdmvFCCv2xKqH8G1AJ5gKgVYvtCaulX3TqxtXNzcqhwLUtrHIes7xAOcJM
	7/twsk2wXUFp6EPei+tEzmwAPaZay6X3veGrksDly+
X-Google-Smtp-Source: AGHT+IFGM18V5BmoNcYUf2okviT2kmAXvknm9jZn5oKlaoNk7p3xJlIfxznSGPSVf/lbXXzEGazn2g==
X-Received: by 2002:a17:903:2451:b0:294:9813:4512 with SMTP id d9443c01a7336-29b6c3dba71mr192201425ad.3.1764092562714;
        Tue, 25 Nov 2025 09:42:42 -0800 (PST)
Received: from ?IPV6:2405:201:31:d869:c163:7f74:bed9:a2d1? ([2405:201:31:d869:c163:7f74:bed9:a2d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b1075basm170831165ad.21.2025.11.25.09.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 09:42:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------45qQ0oCK0HZ0Ruk4XZVcr08P"
Message-ID: <3e74d313-99df-4aeb-87b3-612f4f3634f0@gmail.com>
Date: Tue, 25 Nov 2025 23:12:38 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>
Subject: Re: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>

This is a multi-part message in MIME format.
--------------45qQ0oCK0HZ0Ruk4XZVcr08P
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

--------------45qQ0oCK0HZ0Ruk4XZVcr08P
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hsr-fix-NULL-pointer-dereference-in-skb_clone-with-h.patch"
Content-Disposition: attachment;
 filename*0="0001-hsr-fix-NULL-pointer-dereference-in-skb_clone-with-h.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA5YmRlODZhZDJlZDYzYWNjMDlhMjVlNjY1MDI4ZGJhZGE3ZjVmMGFjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTaGF1cnlhIFJhbmUgPHNzcmFuZV9iMjNAZWUudmp0
aS5hYy5pbj4KRGF0ZTogVHVlLCAyNSBOb3YgMjAyNSAyMzowMjozMyArMDUzMApTdWJqZWN0
OiBbUEFUQ0hdIGhzcjogZml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBza2JfY2xv
bmUgd2l0aCBodyB0YWcKIGluc2VydGlvbgoKV2hlbiBoYXJkd2FyZSBIU1IgdGFnIGluc2Vy
dGlvbiBpcyBlbmFibGVkIChORVRJRl9GX0hXX0hTUl9UQUdfSU5TKSBhbmQKZnJhbWUtPnNr
Yl9zdGQgaXMgTlVMTCwgYm90aCBoc3JfY3JlYXRlX3RhZ2dlZF9mcmFtZSgpIGFuZApwcnBf
Y3JlYXRlX3RhZ2dlZF9mcmFtZSgpIHdpbGwgY2FsbCBza2JfY2xvbmUoKSB3aXRoIGEgTlVM
TCBza2IgcG9pbnRlciwKY2F1c2luZyBhIGtlcm5lbCBjcmFzaC4KCkZpeCB0aGlzIGJ5IGFk
ZGluZyBOVUxMIGNoZWNrcyBmb3IgZnJhbWUtPnNrYl9zdGQgYmVmb3JlIGNhbGxpbmcKc2ti
X2Nsb25lKCkgaW4gYm90aCBmdW5jdGlvbnMuCgpSZXBvcnRlZC1ieTogc3l6Ym90KzJmYTM0
NDM0OGE1NzliNzc5ZTA1QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KRml4ZXM6IGYyNjZh
NjgzYTQ4MCAoXCJuZXQvaHNyOiBCZXR0ZXIgZnJhbWUgZGlzcGF0Y2hcIikKU2lnbmVkLW9m
Zi1ieTogU2hhdXJ5YSBSYW5lIDxzc3JhbmVfYjIzQGVlLnZqdGkuYWMuaW4+Ci0tLQogbmV0
L2hzci9oc3JfZm9yd2FyZC5jIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvbmV0L2hzci9oc3JfZm9yd2FyZC5jIGIvbmV0L2hzci9o
c3JfZm9yd2FyZC5jCmluZGV4IDMzOWYwZDIyMDIxMi4uN2JkODI3NjdjNTQ0IDEwMDY0NAot
LS0gYS9uZXQvaHNyL2hzcl9mb3J3YXJkLmMKKysrIGIvbmV0L2hzci9oc3JfZm9yd2FyZC5j
CkBAIC0zNDEsNiArMzQxLDggQEAgc3RydWN0IHNrX2J1ZmYgKmhzcl9jcmVhdGVfdGFnZ2Vk
X2ZyYW1lKHN0cnVjdCBoc3JfZnJhbWVfaW5mbyAqZnJhbWUsCiAJCWhzcl9zZXRfcGF0aF9p
ZChmcmFtZSwgaHNyX2V0aGhkciwgcG9ydCk7CiAJCXJldHVybiBza2JfY2xvbmUoZnJhbWUt
PnNrYl9oc3IsIEdGUF9BVE9NSUMpOwogCX0gZWxzZSBpZiAocG9ydC0+ZGV2LT5mZWF0dXJl
cyAmIE5FVElGX0ZfSFdfSFNSX1RBR19JTlMpIHsKKwkJaWYgKCFmcmFtZS0+c2tiX3N0ZCkK
KwkJCXJldHVybiBOVUxMOwogCQlyZXR1cm4gc2tiX2Nsb25lKGZyYW1lLT5za2Jfc3RkLCBH
RlBfQVRPTUlDKTsKIAl9CiAKQEAgLTM4NSw2ICszODcsOCBAQCBzdHJ1Y3Qgc2tfYnVmZiAq
cHJwX2NyZWF0ZV90YWdnZWRfZnJhbWUoc3RydWN0IGhzcl9mcmFtZV9pbmZvICpmcmFtZSwK
IAkJfQogCQlyZXR1cm4gc2tiX2Nsb25lKGZyYW1lLT5za2JfcHJwLCBHRlBfQVRPTUlDKTsK
IAl9IGVsc2UgaWYgKHBvcnQtPmRldi0+ZmVhdHVyZXMgJiBORVRJRl9GX0hXX0hTUl9UQUdf
SU5TKSB7CisJCWlmICghZnJhbWUtPnNrYl9zdGQpCisJCQlyZXR1cm4gTlVMTDsKIAkJcmV0
dXJuIHNrYl9jbG9uZShmcmFtZS0+c2tiX3N0ZCwgR0ZQX0FUT01JQyk7CiAJfQogCi0tIAoy
LjM0LjEKCg==

--------------45qQ0oCK0HZ0Ruk4XZVcr08P--

