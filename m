Return-Path: <netdev+bounces-121528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8B895D86C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD73285A3D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A619046E;
	Fri, 23 Aug 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1l+hOXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21D80C02;
	Fri, 23 Aug 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724448171; cv=none; b=skuLhRJav3r5tCbjwecdnXinTlJJuiZJuAo9bLZelUf8I5W/rP0wfTojWLsPyrkdO4fHfKRPxgS+MB1nLov/aacWGvAUP0vU7Wk+3o/Mr7AXSqInVVE7q2fwh4u0PNiDqRCHlXfe3YW3Y8K+UBdZHtlJ3TMdEk7onziyrqCsd/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724448171; c=relaxed/simple;
	bh=fsuiFymIGDNHKkSXYuiSoQn+bA4Lgbc9l2CJW76xlxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5KGCDZCQhRA3dKuDZDieZpA/oCLBJhW+TKgDagjK56WWNazVtI8kabgAAvH2lo9WdNKAx1ZZO9e29eHm1r+OyGlcMngJjeQlO0sKVmXDyX1+0Pke+n9fr38vMZs+KtNQbGeAk9NkIvl06r8pBwlJGRf/4PM7orrrr+FCAuyXGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1l+hOXw; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5daa683b298so2058792eaf.0;
        Fri, 23 Aug 2024 14:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724448169; x=1725052969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwzmMypr/sudQP9DWc+vswO1E4bY4IocnhbqPyge0uw=;
        b=g1l+hOXwPSotD7jXJCwy+VPwmza/y/sV5RKjGJIuk1Mocd9bpam+HCU7JcGKIhr6rZ
         4t88smnt4ou0P0c0pjOW+XvBVAtdq7O8AL6xyinY5qY2DmzMJDIglAS4AuYntE4YkzZ+
         jvhA2yv3ajkSeZhzd8G/y08faOAlzJ2WT3H2Nr29w9krxfEVZPGjwTRYs5yW6umz6r9a
         se0v0sjNSw+gYuCblvTGc7tAsiynvOsUJbGS64Y7MnoLtAtY4hfv2XzEc3dx+JgHGibO
         SOVOZ8P7EAPN68Mid7zEVOKGGzjzOMdG8El4y8Y70a4eOjmZ9wkvCi7OGhecF4xfIcER
         WKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724448169; x=1725052969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwzmMypr/sudQP9DWc+vswO1E4bY4IocnhbqPyge0uw=;
        b=HhIkT52TvGCK9FJd/l4EBPu4twcPpcKnPhSo7lelJqP0ChKKDNcJCDxv89SENdhJjf
         ufMgg6PbgzHBjMNWC7uJiJtn32TTPa6lQzoXuqRq5AqYar0C+ohnLsPq6mhS8prFSnv3
         6+g1XIpnMgDA6Z3J7Q3dAIG05qycaOLQxyWIvCd1lWpkCqJb5P6BgVcLq2KW5L9qkGMU
         XXBmEuTNYzB+WGAt2jOPxekGLP1I5INebw05NyJ8RcQau+zU103V5BtEniqCabdAQ+tJ
         iUMTILkQHVFlfsl5gnhRQTMfSrwiZ3S4KJUY6QusvMyjankKLvB0QyYhBD8GdHqHj+V9
         0vRg==
X-Forwarded-Encrypted: i=1; AJvYcCVU3SIhJmwiZG+oajZ3TXxEvxidpzsPGCbGCudkWBnaTpRqgj07k/coeXLXZ4SQO9iIi1SbLrcEZbkXfEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7C1XAfC8qWR2JwkmzmqNSLLcsyfWkG7HIo8GFMx6dI+ZKiui
	VMq83zKo0n+XTnBRJl0civvy9CQrsgjVRUdrn0RwWIZmzoOUCpf/mHBajYUhIawfPfBNRzOv0mD
	Lhmus4wl/e3NMfLTqOEU3nt7NYK4=
X-Google-Smtp-Source: AGHT+IEE01aI4Oij/Yx3LwGRYD51G7B/uHnfCIzyR2ApkRyaDSybp9unfrzql2mQKO9fLurNG88gvQ7+Lr7USuC6bzI=
X-Received: by 2002:a05:6820:221b:b0:5da:b2a0:2cd1 with SMTP id
 006d021491bc7-5dcc6338148mr3246110eaf.7.1724448169223; Fri, 23 Aug 2024
 14:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823084220.258965-1-arkadiusz.kubalewski@intel.com>
 <m2le0n5xpn.fsf@gmail.com> <DM6PR11MB46578FDE21C9E875A7F3C1BE9B882@DM6PR11MB4657.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB46578FDE21C9E875A7F3C1BE9B882@DM6PR11MB4657.namprd11.prod.outlook.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 23 Aug 2024 22:22:37 +0100
Message-ID: <CAD4GDZza0TWkzmwW_qP8GFXzr7DOGVfg-xsiXOVUyRqe47Rung@mail.gmail.com>
Subject: Re: [RFC PATCH net] tools/net/ynl: fix cli.py --subscribe feature
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"Keller, Jacob E" <jacob.e.keller@intel.com>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 20:31, Kubalewski, Arkadiusz
<arkadiusz.kubalewski@intel.com> wrote:
>
> >The problem is that we are trying to look up the op before calling
> >nlproto.decode(...) but it wants to know the op to check if it has a
> >fixed header.
> >
> >I think the fix would be to change NetlinkProtocol.decode() to perform
> >the op lookup, if necessary, after it has called self._decode() to
> >unpack the GenlMsg.
> >
> >How about changing NetlinkProtocol.decode() to be:
> >
> >def decode(self, ynl, nl_msg, op, ops_by_value):
> >    msg = self._decode(nl_msg)
> >    if op is None:
> >        op = ops_by_value[msg.cmd()]
> >    ...
> >
> >The main loop can call it like this:
> >
> >nlproto.decode(self, nl_msg, op, self.rsp_by_value)
> >
> >and check_ntf() can call it like this:
> >
> >nlproto.decode(self, nl_msg, None, self.rsp_by_value)
> >
>
> Yes, again, this seems much better, I will prepare new patch and send
> the non-RFC version soon.
>
> Thanks for your help!
> Arkadiusz

I tried the changes locally to check it would work and ended up with
the following patch. Can you verify that it fixes the issue you had?

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index d42c1d605969..311542a8aa24 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -386,8 +386,10 @@ class NetlinkProtocol:
     def _decode(self, nl_msg):
         return nl_msg

-    def decode(self, ynl, nl_msg, op):
+    def decode(self, ynl, nl_msg, op, ops_by_value):
         msg = self._decode(nl_msg)
+        if op is None:
+            op = ops_by_value[msg.cmd()]
         fixed_header_size = ynl._struct_size(op.fixed_header)
         msg.raw_attrs = NlAttrs(msg.raw, fixed_header_size)
         return msg
@@ -921,8 +923,7 @@ class YnlFamily(SpecFamily):
                     print("Netlink done while checking for ntf!?")
                     continue

-                op = self.rsp_by_value[nl_msg.cmd()]
-                decoded = self.nlproto.decode(self, nl_msg, op)
+                decoded = self.nlproto.decode(self, nl_msg, None,
self.rsp_by_value)
                 if decoded.cmd() not in self.async_msg_ids:
                     print("Unexpected msg id done while checking for
ntf", decoded)
                     continue
@@ -980,7 +981,7 @@ class YnlFamily(SpecFamily):
                     if nl_msg.extack:
                         self._decode_extack(req_msg, op, nl_msg.extack)
                 else:
-                    op = self.rsp_by_value[nl_msg.cmd()]
+                    op = None
                     req_flags = []

                 if nl_msg.error:
@@ -1004,7 +1005,7 @@ class YnlFamily(SpecFamily):
                     done = len(reqs_by_seq) == 0
                     break

-                decoded = self.nlproto.decode(self, nl_msg, op)
+                decoded = self.nlproto.decode(self, nl_msg, op,
self.rsp_by_value)

                 # Check if this is a reply to our request
                 if nl_msg.nl_seq not in reqs_by_seq or decoded.cmd()
!= op.rsp_value:

