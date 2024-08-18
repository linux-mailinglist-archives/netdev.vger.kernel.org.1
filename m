Return-Path: <netdev+bounces-119470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4206E955CC2
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 15:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF8E1F21366
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5401E21340;
	Sun, 18 Aug 2024 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXTtNJ9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D04E2AD2C
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723987759; cv=none; b=LicpIRc3WNnmu7ws5yZo1Vf/L1YE1S0dKV4wLyhT8EfGkBW+xRxIgv9eX3l7DPX+4AyOPgAAVGffNs1EZ6nPVch3xaoUnGI0itE3Nn9M+qYeaTQGlRSIIrOp6CQ49kij30vdLqxHqgK3yqSKG3vHrHLfaQ1vJ0XihuuxMhfm10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723987759; c=relaxed/simple;
	bh=QohLvEUfbLhbb3p/vlK8y2qAdm5fRVOpBlG0ngHPJzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9bi6zTohhGrJaidTQbItL53ulsEeBu1/P59DoYI8n8bnstkP2KAyZ2rNrF3w/PQn+Lat/Aq+H8jUnsOAXuQNxb7P2Ax0mnUQ+9nVuio+KNBx3m8KH5EUUmSadGBh/1qK4fKmC+NAYIp38Qiz1qMSAhSqdukhJ8MCMgHBlepNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXTtNJ9L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428163f7635so29695405e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723987755; x=1724592555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kye8l/a5qohxC9xo4mF5TqSx2hpuep6xWNFkvugvVMc=;
        b=gXTtNJ9L/t5XZUk7K6O8nRbWaZE9KUbKq62BxowBnD31/nCnDZmumdOZDia/oQglBX
         RX9ZVLlDAnQYgMHUDBiOPyfuYza5FrUGzhuqylITZ2R4Teu7SpwNzb3/zlHQALSaipI4
         qQC6gon9t/qS8rBZkY4Le2flUj8i0Ut/fAeE/121tZ5+MaqttA42USqRVKgZ9QubBOiZ
         kl9RjYv4aHD1e0etBMoZaV5zrOcHaNa5LD+YgDo+W2m2S4bo28EWEQzdxBhm8mgEP6Sw
         cNo5nG86jZTFaQNEwnyzsbyvCXjK9/WmfQ11XQ/do4qUS07KUeLLhiGgFxv0dWWFvonn
         Cn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723987755; x=1724592555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kye8l/a5qohxC9xo4mF5TqSx2hpuep6xWNFkvugvVMc=;
        b=hj/PGufrvcUbBrFG564CGCjdAo9XemT/FX3XOt8uRUFkcSRUuL8MjAZjfv2Bpgrfho
         u/NhQo2eq6/gbzgtpXkbPGE6ngjlg6brOovtLP3feFeZCDn+/j6icTcjSMxaQP9G8yJR
         3HIr6NVKLmj8mmMH+0te7Hdkxi+JToioVGtIiXgPrHVfHGVPejrUsWNur5jopQRKrVTO
         qTAeUebF5jZa/1jgxN8rbDxffmQtJByszI8vPnbEI5uTDpS4+RGeNKEMXuwIbpvYwvSo
         AyNscJMiWr1g4EAmXNL4dVTVp0ZweuveZkff5c950B9ol5s1i+i7nbnV0BzkGooSFpfI
         cR6w==
X-Gm-Message-State: AOJu0YyecR1xbCVTfAR6+Fzihh5jFmBlRkOgA0zgv0aRMhzIKnvQENK3
	wW2P9evbcBLUSgWXlIi+owU454aG6O9ZCQJkNmhG4Zdmp4F+8DT+
X-Google-Smtp-Source: AGHT+IF2ZF+JCQrTz7cIRNWhhMNx0Y/gilsGm1Ipe0kWgsTmOJGyEsbtPgVZsMKbz+4sGEkB/yaRtg==
X-Received: by 2002:a05:600c:1c25:b0:429:a0d:b710 with SMTP id 5b1f17b1804b1-429ed79c76fmr50654205e9.12.1723987754779;
        Sun, 18 Aug 2024 06:29:14 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm141977025e9.0.2024.08.18.06.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 06:29:12 -0700 (PDT)
Date: Sun, 18 Aug 2024 16:29:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
Message-ID: <20240818132910.jmsvqg363vkzbaxw@skbuf>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ro6pev4munz3pgj3"
Content-Disposition: inline
In-Reply-To: <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>


--ro6pev4munz3pgj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jake,

On Fri, Aug 16, 2024 at 04:37:22PM -0700, Jacob Keller wrote:
> I'm honestly not sure what the right solution here is, because the way
> LITTLE_ENDIAN and LSW32_IS_FIRST work they effectively *require*
> word-aligned sizes. If we use a word-aligned size, then they both make
> sense, but my hardware buffer isn't word aligned. I can cheat, and just
> make sure I never use bits that access the invalid parts of the buffer..
> but that seems like the wrong solution... A larger size would break
> normal Big endian ordering without quirks...

It is a use case that I would like to support. Thanks for having the
patience to explain the issue to me.

> Really, what my hardware buffer wants is to map the lowest byte of the
> data to the lowest byte of the buffer. This is what i would consider
> traditionally little endian ordering.
> 
> This also happens to be is equivalent to LSW32_IS_FIRST and
> LITTLE_ENDIAN when sizes are multiples of 4.

Yes, "traditionally little endian" would indeed translate into
QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN. Your use of the API seems
correct. I did need that further distinction between "little endian
within a group of 4 bytes" and "little endian among groups of 4 bytes"
because the NXP SJA1105 memory layout is weird like that, and is
"little endian" in one way but not in another. Anyway..

I've attached 2 patches which hopefully make the API usable for your
driver. I've tested them locally and did not notice issues.

--ro6pev4munz3pgj3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-lib-packing-refuse-operating-on-bit-indices-which-ex.patch"

From 8314f556f30e5e76973b1bcf1c552ff4a23621b9 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 18 Aug 2024 15:50:56 +0300
Subject: [PATCH 1/2] lib: packing: refuse operating on bit indices which
 exceed size of buffer

While reworking the implementation, it became apparent that this check
does not exist.

There is no functional issue yet, because at call sites, "startbit" and
"endbit" are always hardcoded to correct values, and never come from the
user.

Even with the upcoming support of arbitrary buffer lengths, the
"startbit >= 8 * pbuflen" check will remain correct. This is because
we intend to always interpret the packed buffer in a way that avoids
discontinuities in the available bit indices.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 lib/packing.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 3f656167c17e..1cb3e0b2a24e 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -86,8 +86,10 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	 */
 	int plogical_first_u8, plogical_last_u8, box;
 
-	/* startbit is expected to be larger than endbit */
-	if (startbit < endbit)
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (startbit < endbit || startbit >= 8 * pbuflen || endbit < 0)
 		/* Invalid function call */
 		return -EINVAL;
 
-- 
2.34.1


--ro6pev4munz3pgj3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-lib-packing-adjust-definitions-and-implementation-fo.patch"

From c37c61b4de3dcc4b7837445f0884f7c67e73f623 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Sun, 18 Aug 2024 15:48:26 +0300
Subject: [PATCH 2/2] lib: packing: adjust definitions and implementation for
 arbitrary buffer lengths

Jacob Keller has a use case for packing() in the intel/ice networking
driver, but it cannot be used as-is.

Simply put, the API quirks for LSW32_IS_FIRST and LITTLE_ENDIAN are
naively implemented with the undocumented assumption that the buffer
length must be a multiple of 4. All calculations of group offsets and
offsets of bytes within groups assume that this is the case. But in the
ice case, this does not hold true. For example, packing into a buffer
of 22 bytes would yield wrong results, but pretending it was a 24 byte
buffer would work.

Rather than requiring such hacks, and leaving a big question mark when
it comes to discontinuities in the accessible bit fields of such buffer,
we should extend the packing API to support this use case.

It turns out that we can keep the design in terms of groups of 4 bytes,
but also make it work if the total length is not a multiple of 4.
Just like before, imagine the buffer as a big number, and its most
significant bytes (the ones that would make up to a multiple of 4) are
missing. Thus, with a big endian (no quirks) interpretation of the
buffer, those most significant bytes would be absent from the beginning
of the buffer, and with a LSW32_IS_FIRST interpretation, they would be
absent from the end of the buffer. The LITTLE_ENDIAN quirk, in the
packing() API world, only affects byte ordering within groups of 4.
Thus, it does not change which bytes are missing. Only the significance
of the remaining bytes within the (smaller) group.

No change intended for buffer sizes which are multiples of 4. Tested
with the sja1105 driver and with downstream unit tests.

Link: https://lore.kernel.org/netdev/a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 Documentation/core-api/packing.rst | 71 ++++++++++++++++++++++++++++++
 lib/packing.c                      | 70 +++++++++++++++++------------
 2 files changed, 114 insertions(+), 27 deletions(-)

diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
index 3ed13bc9a195..821691f23c54 100644
--- a/Documentation/core-api/packing.rst
+++ b/Documentation/core-api/packing.rst
@@ -151,6 +151,77 @@ the more significant 4-byte word.
 We always think of our offsets as if there were no quirk, and we translate
 them afterwards, before accessing the memory region.
 
+Note on buffer lengths not multiple of 4
+----------------------------------------
+
+To deal with memory layout quirks where groups of 4 bytes are laid out "little
+endian" relative to each other, but "big endian" within the group itself, the
+concept of groups of 4 bytes is intrinsic to the packing API (not to be
+confused with the memory access, which is performed byte by byte, though).
+
+With buffer lengths not multiple of 4, this means one group will be incomplete.
+Depending on the quirks, this may lead to discontinuities in the bit fields
+accessible through the buffer. The packing API assumes discontinuities were not
+the intention of the memory layout, so it avoids them by effectively logically
+shortening the most significant group of 4 octets to the number of octets
+actually available.
+
+Example with a 31 byte sized buffer given below. Physical buffer offsets are
+implicit, and increase from left to right within a group, and from top to
+bottom within a column.
+
+No quirks:
+
+::
+
+            31         29         28        |   Group 7 (most significant)
+ 27         26         25         24        |   Group 6
+ 23         22         21         20        |   Group 5
+ 19         18         17         16        |   Group 4
+ 15         14         13         12        |   Group 3
+ 11         10          9          8        |   Group 2
+  7          6          5          4        |   Group 1
+  3          2          1          0        |   Group 0 (least significant)
+
+QUIRK_LSW32_IS_FIRST:
+
+::
+
+  3          2          1          0        |   Group 0 (least significant)
+  7          6          5          4        |   Group 1
+ 11         10          9          8        |   Group 2
+ 15         14         13         12        |   Group 3
+ 19         18         17         16        |   Group 4
+ 23         22         21         20        |   Group 5
+ 27         26         25         24        |   Group 6
+ 30         29         28                   |   Group 7 (most significant)
+
+QUIRK_LITTLE_ENDIAN:
+
+::
+
+            30         28         29        |   Group 7 (most significant)
+ 24         25         26         27        |   Group 6
+ 20         21         22         23        |   Group 5
+ 16         17         18         19        |   Group 4
+ 12         13         14         15        |   Group 3
+  8          9         10         11        |   Group 2
+  4          5          6          7        |   Group 1
+  0          1          2          3        |   Group 0 (least significant)
+
+QUIRK_LITTLE_ENDIAN | QUIRK_LSW32_IS_FIRST:
+
+::
+
+  0          1          2          3        |   Group 0 (least significant)
+  4          5          6          7        |   Group 1
+  8          9         10         11        |   Group 2
+ 12         13         14         15        |   Group 3
+ 16         17         18         19        |   Group 4
+ 20         21         22         23        |   Group 5
+ 24         25         26         27        |   Group 6
+ 28         29         30                   |   Group 7 (most significant)
+
 Intended use
 ------------
 
diff --git a/lib/packing.c b/lib/packing.c
index 1cb3e0b2a24e..bfc40103f821 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -9,27 +9,6 @@
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
-static int get_le_offset(int offset)
-{
-	int closest_multiple_of_4;
-
-	closest_multiple_of_4 = (offset / 4) * 4;
-	offset -= closest_multiple_of_4;
-	return closest_multiple_of_4 + (3 - offset);
-}
-
-static int get_reverse_lsw32_offset(int offset, size_t len)
-{
-	int closest_multiple_of_4;
-	int word_index;
-
-	word_index = offset / 4;
-	closest_multiple_of_4 = word_index * 4;
-	offset -= closest_multiple_of_4;
-	word_index = (len / 4) - word_index - 1;
-	return word_index * 4 + offset;
-}
-
 static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
 				       int *box_end_bit, u8 *box_mask)
 {
@@ -47,6 +26,48 @@ static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
 	*box_end_bit   = new_box_end_bit;
 }
 
+/**
+ * calculate_box_addr - Determine physical location of byte in buffer
+ * @box: Index of byte within buffer seen as a logical big-endian big number
+ * @len: Size of buffer in bytes
+ * @quirks: mask of QUIRK_LSW32_IS_FIRST and QUIRK_LITTLE_ENDIAN
+ *
+ * Function interprets the buffer as a @len byte sized big number, and returns
+ * the physical offset of the @box logical octet within it. Internally, it
+ * treats the big number as groups of 4 bytes. If @len is not a multiple of 4,
+ * the last group may be shorter.
+ *
+ * @QUIRK_LSW32_IS_FIRST gives the ordering of groups of 4 octets relative to
+ * each other. If set, the most significant group of 4 octets is last in the
+ * buffer (and may be truncated if @len is not a multiple of 4).
+ *
+ * @QUIRK_LITTLE_ENDIAN gives the ordering of bytes within each group of 4.
+ * If set, the most significant byte is last in the group. If @len takes the
+ * form of 4k+3, the last group will only be able to represent 24 bits, and its
+ * most significant octet is byte 2.
+ *
+ * Returns the physical offset into the buffer corresponding to the logical box.
+ */
+static int calculate_box_addr(int box, size_t len, int quirks)
+{
+	size_t offset_of_group, offset_in_group, this_group = box / 4;
+	size_t group_size;
+
+	if (quirks & QUIRK_LSW32_IS_FIRST)
+		offset_of_group = this_group * 4;
+	else
+		offset_of_group = len - ((this_group + 1) * 4);
+
+	group_size = min(4, len - offset_of_group);
+
+	if (quirks & QUIRK_LITTLE_ENDIAN)
+		offset_in_group = box - this_group * 4;
+	else
+		offset_in_group = group_size - (box - this_group * 4) - 1;
+
+	return offset_of_group + offset_in_group;
+}
+
 /**
  * packing - Convert numbers (currently u64) between a packed and an unpacked
  *	     format. Unpacked means laid out in memory in the CPU's native
@@ -157,12 +178,7 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 		 * effective addressing inside the pbuf (so it's not
 		 * logical any longer).
 		 */
-		box_addr = pbuflen - box - 1;
-		if (quirks & QUIRK_LITTLE_ENDIAN)
-			box_addr = get_le_offset(box_addr);
-		if (quirks & QUIRK_LSW32_IS_FIRST)
-			box_addr = get_reverse_lsw32_offset(box_addr,
-							    pbuflen);
+		box_addr = calculate_box_addr(box, pbuflen, quirks);
 
 		if (op == UNPACK) {
 			u64 pval;
-- 
2.34.1


--ro6pev4munz3pgj3--

